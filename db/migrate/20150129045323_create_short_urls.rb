class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
       # the real url that we will redirect to
      t.string :url, :null => false

      # the unique key
      t.string :uid, :limit => 10, :null => false

      # how many times the link has been clicked
      t.integer :hits, :null => false, :default => 0

      t.timestamps
    end

    add_index :short_urls, :uid, :unique => true
    add_index :short_urls, :url
  end
end
