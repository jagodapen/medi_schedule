class ChangeGenderColumnInPatients < ActiveRecord::Migration[7.0]
  def change
    remove_column :patients, :gender, :string
    add_column :patients, :gender, :integer
  end
end
