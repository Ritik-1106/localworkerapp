class RenameJobapplicationsToJobApplications < ActiveRecord::Migration[7.2]
  def change
    rename_table :jobapplications, :job_applications
  end
end
