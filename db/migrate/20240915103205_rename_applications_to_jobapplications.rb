class RenameApplicationsToJobapplications < ActiveRecord::Migration[7.2]
  def change
    rename_table :applications, :jobapplications
  end
end
