class AddUsernamePicture < ActiveRecord::Migration
  def self.up
    add_column :techpeeps, :username, :string, :limit => 30
    add_column :techpeeps, :picture, :string
  end

  def self.down
  end
end
