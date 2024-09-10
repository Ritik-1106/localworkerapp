class Adduser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :contact_no, :string, null: false
    add_column :users, :location, :string, null: false
  end
end
