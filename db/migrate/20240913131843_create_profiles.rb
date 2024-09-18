class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.integer :age
      t.integer :graduation
      t.integer :postgraduation
      t.integer :graduation_year
      t.integer :postgraduation_year
      t.text :skills
      t.string :country
      t.string :aadhar_no
      t.integer :experience

      t.timestamps
    end
  end
end
