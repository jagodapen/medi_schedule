class AddCurrencyToAppointments < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE currencies AS ENUM ('PLN', 'EUR');
    SQL
    add_column :appointments, :currency, :currencies
  end

  def down
    remove_column :appointments, :currency
    execute <<-SQL
      DROP TYPE currencies;
    SQL
  end
end
