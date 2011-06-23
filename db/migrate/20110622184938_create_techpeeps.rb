class CreateTechpeeps < ActiveRecord::Migration
  def self.up
    create_table :techpeeps, :id => :user_id do |t|
      t.column :twitter_id, :string, :limit => 50
      t.column :count, :integer       
      t.column :tweets, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :techpeeps
  end
end
