class AddForeignKeysToApplications < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :applications, :jobs

    # Add foreign key for worker_id (referencing users table)
    add_foreign_key :applications, :users, column: :worker_id
  end
end
