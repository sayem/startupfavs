class CreateTechpeeps < ActiveRecord::Migration
  def self.up
    create_table :techpeeps, :id => :user_id do |t|
      t.column :twitter_id, :string, :limit => 50
      t.column :sun, :text 
      t.column :mon, :text       
      t.column :tue, :text       
      t.column :wed, :text       
      t.column :thu, :text       
      t.column :fri, :text       
      t.column :sat, :text       

      t.timestamps
    end
  end

  def self.down
    drop_table :techpeeps
  end
end
