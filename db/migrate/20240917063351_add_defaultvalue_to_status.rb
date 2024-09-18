class AddDefaultvalueToStatus < ActiveRecord::Migration[7.2]
  def change
   change_column_default :job_applications, :status, from: nil, to: "Pending"
  end
end
