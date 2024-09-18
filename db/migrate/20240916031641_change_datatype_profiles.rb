class ChangeDatatypeProfiles < ActiveRecord::Migration[7.2]
  def change
    change_column :profiles, :graduation, :string
    change_column :profiles, :postgraduation, :string
  end
end
