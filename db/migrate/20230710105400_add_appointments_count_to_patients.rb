class AddAppointmentsCountToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :appointments_count, :integer
  end
end
