class AddVacanciescolumnJobs < ActiveRecord::Migration[7.2]
  def change
    add_column :jobs, :vacancies, :integer, default: 1
  end
end
