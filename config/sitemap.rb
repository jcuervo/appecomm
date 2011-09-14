# Set the host name for URL creation
# https://github.com/kjvarga/sitemap_generator
SitemapGenerator::Sitemap.default_host = APP_CONFIG['site_url']
SitemapGenerator::Sitemap.yahoo_app_id = APP_CONFIG['yahoo_app_id']
SitemapGenerator::Sitemap.create do

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  
  Product.find_each do |product|
    add product_path(product), :lastmod => product.updated_at
  end
  
  Article.find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end
end
