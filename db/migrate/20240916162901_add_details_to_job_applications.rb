class AddDetailsToJobApplications < ActiveRecord::Migration[7.2]
  def change
   add_column :jobapplications, :description, :text
   add_column :jobapplications, :softskills, :text
   add_column :jobapplications, :expected_salary, :string
  end
end
