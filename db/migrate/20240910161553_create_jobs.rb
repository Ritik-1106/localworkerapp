class CreateJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :timing
      t.string :salary
      t.text :description
      t.integer :contractor_id
      t.integer :category_id
      t.string :location

      t.timestamps
    end
  end
end
