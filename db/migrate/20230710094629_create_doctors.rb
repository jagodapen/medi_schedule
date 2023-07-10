class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :first_name, presence: true
      t.string :last_name, presence: true
      t.string :faculty

      t.timestamps
    end
  end
end
