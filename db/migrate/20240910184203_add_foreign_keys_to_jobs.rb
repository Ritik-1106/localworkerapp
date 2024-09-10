class AddForeignKeysToJobs < ActiveRecord::Migration[7.2]
  def change
    # Add foreign key for contractor_id (referencing users table)
    add_foreign_key :jobs, :users, column: :contractor_id

    # Add foreign key for category_id (referencing categories table)
    add_foreign_key :jobs, :categories, column: :category_id
  end
end
