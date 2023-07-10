class ChangeGenderColumnInPatients < ActiveRecord::Migration[7.0]
  def change
    def up
      execute <<-SQL
        CREATE TYPE genders AS ENUM ('female', 'male', 'not_set');
      SQL
      remove_column :patients, :gender, :string
      add_column :patients, :gender, :genders
    end
  
    def down
      remove_column :patients, :gender
      execute <<-SQL
        DROP TYPE genders;
      SQL
    end
  end
end
