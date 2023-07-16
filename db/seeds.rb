# Destroy all existing doctors to avoid validation errors
Doctor.destroy_all
# Create doctors
Doctor.create(first_name: "JAN", last_name: "WALCZAK", faculty: "INTERNISTA")
Doctor.create(first_name: "ADAM", last_name: "MIAUCZYŃSKI", faculty: "PSYCHOLOG")
Doctor.create(first_name: "MAKS", last_name: "PARADYS", faculty: "ORTOPEDA")
Doctor.create(first_name: "BOŻENA", last_name: "LUBICZ", faculty: "UROLOG")
Doctor.create(first_name: "MARTA", last_name: "GESLAR", faculty: "GASTROLOG")

# Destroy all existing patients to avoid validation errors
Patient.destroy_all
# Create patients
Patient.create(first_name: "BARBARA", last_name: "SZUSZKIEWICZ", pesel: "50072065465", birth_date: "20-07-1950".to_date, city: "LUBLIN", gender: "female")
Patient.create(first_name: "DOMINIK", last_name: "KWIEK", pesel: "72111985396", birth_date: "19-11-1972".to_date, city: "KIELCE", gender: "female")
Patient.create(first_name: "LEON", last_name: "HNAT", pesel: "67011232577", birth_date: "12-01-1967".to_date, city: "RYBNIK", gender: "male")
Patient.create(first_name: "JAKUB", last_name: "ŚMIESZEK",pesel: "82040995597", birth_date: "1982-04-09".to_date, city: "GDAŃSK", gender: "male")
Patient.create(first_name: "NADIA", last_name: "ZOZULIA" ,pesel: "66061462669", birth_date: "1966-06-14".to_date, city: "KRAKÓW", gender: "female")
Patient.create(first_name: "MATYLDA", last_name: "SZAŁEK", pesel: "94092814322", birth_date: "1994-09-28".to_date, city: "CZĘSTOCHOWA", gender: "female")
Patient.create(first_name: "HANNA", last_name: "LIZUREJ", pesel: "76091932925", birth_date: "1976-09-19".to_date, city: "ŁÓDŹ", gender: "female")
Patient.create(first_name: "MIŁOSZ", last_name:"KOŁODZIŃSKI", pesel: "59062351575", birth_date: "1959-06-23".to_date, city: "OLSZTYN", gender: "male")
Patient.create(first_name: "KAROL", last_name: "BERNAT", pesel: "70072788330", birth_date: "1970-07-27".to_date, city: "KATOWICE", gender: "male")
Patient.create(first_name: "IGA", last_name: "ZIEJA", pesel: "57112098685", birth_date: "1957-11-20".to_date, city: "KIELCE", gender: "female")
Patient.create(first_name: "HELENA", last_name: "OLSZOWY", pesel: "92112464282", birth_date: "1992-11-24".to_date, city: "TORUŃ", gender: "female")
Patient.create(first_name: "IGNACY", last_name: "KUBANEK", pesel: "77050606131", birth_date: "1977-05-06".to_date, city: "RYBNIK", gender: "male")
Patient.create(first_name: "GABRIELA", last_name: "STEINKE", pesel: "67052027721", birth_date: "1967-05-20".to_date, city: "GDAŃSK", gender: "female")
Patient.create(first_name: "RÓŻA", last_name: "KRAUZE", pesel: "91090534802", birth_date: "1991-09-05".to_date, city: "RADOM", gender: "female")
Patient.create(first_name: "JULIA", last_name: "STEPANIUK", pesel: "79100956548", birth_date: "1979-10-09".to_date, city: "GDYNIA", gender: "female")

# Destroy all existing appointments to avoid validation errors
Appointment.destroy_all
# Create appointments
50.times do
  Appointment.create(
    patient_id: Patient.all.sample.id,
    doctor_id: Doctor.all.sample.id,
    start_time: DateTime.now.next_week.in_time_zone("Europe/Warsaw").change(hour: rand(8..15), min: [0, 20, 40].sample) + rand(0..4).days,
    duration: 20,
    cost: rand(100..200),
    currency: "pln",
  )
end
