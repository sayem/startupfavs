class AddLastTweet < ActiveRecord::Migration
  def self.up
    add_column :techpeeps, :last_tweet, :text
  end
  
  def self.down
  end
end
