class RemoveTimingFromjobs < ActiveRecord::Migration[7.2]
  def change
    remove_column :jobs, :timing, :string
  end
end
