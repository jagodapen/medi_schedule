class RenamePeselNumberInPatients < ActiveRecord::Migration[7.0]
  def change
    rename_column :patients, :pesel_number, :pesel
  end
end
