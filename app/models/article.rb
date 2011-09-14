require 'fgraph'
require 'twitter'
require 'bitly'

class Article < ActiveRecord::Base
  validates :title, :presence => true
  validates :content, :presence => true
  
  after_create :social_media_sync
  default_scope :order => "created_at"
  
  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
  
  private
    def social_media_sync
      if self.fb_publish == true || self.twitter_publish == true
        #create the raw URL
        raw_url = "#{APP_CONFIG['site_url']}/articles/#{self.to_param}"
        if self.fb_publish == true
          publish_token = FGraph.oauth_access_token(APP_CONFIG['fb_app_id'], APP_CONFIG['fb_oauth'], :type => 'client_cred')
          if publish_token
            fb_response = FGraph.publish_feed(APP_CONFIG['fb_app_id'], 
              :message => self.title,
              :link => raw_url,
              :access_token => publish_token["access_token"])
            if fb_response.response == "OK"
              puts "shet!"
            else
              puts "fuck yeah!"
            end
          else
            puts "fuck!"
          end
        end
        if self.twitter_publish == true
          #Technoverge twitter app
          #https://github.com/jnunemaker/twitter
          Twitter.configure do |config|
            config.consumer_key = APP_CONFIG['twitter_consumer_key']
            config.consumer_secret = APP_CONFIG['twitter_consumer_secret']
            config.oauth_token = APP_CONFIG['twitter_oauth_token']
            config.oauth_token_secret = APP_CONFIG['twitter_oauth_token_secret']
          end
          Twitter.update("#{self.title[0..(APP_CONFIG['twitter_msg_length']).to_i]} #{create_shortlink(raw_url)} ##{APP_CONFIG['twitter_app_hash']}")
        end
      end
    end
  
    def create_shortlink(raw_url)
      #https://github.com/philnash/bitly
      #http://code.google.com/p/bitly-api/wiki/ApiDocumentation
      Bitly.use_api_version_3
      bitly = Bitly.new(APP_CONFIG['bitly_id'], APP_CONFIG['bitly_api_key'])
      if bitly
        new_link = bitly.shorten(raw_url)
        if new_link
          return new_link.short_url
        else
          puts "something wrong happened"
          return ""
        end
      else
        # TODO: handle the errors
        return ""
      end
    end
end
