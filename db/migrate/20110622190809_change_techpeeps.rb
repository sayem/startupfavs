class ChangeTechpeeps < ActiveRecord::Migration
  def self.up
    add_index :techpeeps, :twitter_id
  end

  def self.down
  end
end
