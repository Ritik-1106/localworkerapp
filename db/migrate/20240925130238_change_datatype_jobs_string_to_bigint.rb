class ChangeDatatypeJobsStringToBigint < ActiveRecord::Migration[7.2]
  def change
   change_column :jobs, :salary, 'bigint USING salary::bigint'
  end
end
