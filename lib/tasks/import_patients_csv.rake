require "activerecord-import"
require "csv"

desc "Import patients data from csv file. Add path to file as task call argument. 
File format requirements: 
- add headers: first_name, last_name, pesel, city
- one patient data in one row"

task import_patients_csv: :environment do
  ARGV.each { |a| task a.to_sym do; end }

  # Validate correctness of csv file
  return "Incorrect use of rake task. Type: rake import_patients_csv <csv_file_path>" if ARGV.count != 2
  return "Incorrect file path" unless File.exist?(ARGV[1])
  # I would also check if this is csv file and has correct format

  # Prepare array with hashed patients params
  patients = []
  counter = 2

  CSV.foreach(ARGV[1], headers: true) do |row|
    data = row.to_h
    Patients::Validators::Pesel.new(pesel: data["pesel"]).call
    birth_date = Patients::Data::BirthDate.find(pesel: data["pesel"])
    gender = Patients::Data::Gender.find(pesel: data["pesel"])
    patient_data = data.merge({"birth_date": birth_date, "gender": gender})
    patients << patient_data
    counter += 1
  rescue  Patients::Validators::Pesel::InvalidPesel, 
          Patients::Validators::Pesel::IncrediblyOld => e
    puts "Skipped row #{counter}: #{e}"
    counter += 1
    next
  end

  # Save patients in database
  import = Patient.import patients, validate_uniqueness: true, track_validation_failures: true, all_or_none: false
  
  # Print import summary
  puts "", "", "Added #{import.ids.size} records", "", ""
  import.failed_instances.map do |failure|
    puts "Skipped row #{failure[0] + 2} #{failure[1].errors.full_messages}"
  end
end
