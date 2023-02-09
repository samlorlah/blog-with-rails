class AddJtiToUser < ActiveRecord::Migration[7.0]
  def self.up
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true
  end
  def self.down
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true
  end
end
