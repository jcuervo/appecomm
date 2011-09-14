class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.boolean :fb_publish
      t.boolean :twitter_publish
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end
end
