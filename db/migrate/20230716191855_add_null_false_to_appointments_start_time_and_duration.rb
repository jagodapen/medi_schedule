class AddNullFalseToAppointmentsStartTimeAndDuration < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :start_time, :datetime, null: false
    change_column :appointments, :duration, :integer, null: false
  end
end
