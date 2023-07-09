class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :first_name, presence: true
      t.string :last_name, presence: true, index: true
      t.string :pesel_number, presence: true, uniqueness: true
      t.date :birth_date, presence: true
      t.string :gender
      t.string :city

      t.timestamps
    end
  end
end
