# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy all existing doctors to avoid validation errors
Doctor.destroy_all
# Create doctors
Doctor.create(first_name: "JAN", last_name: "WALCZAK", faculty: "INTERNISTA")
Doctor.create(first_name: "ADAM", last_name: "MIAUCZYŃSKI", faculty: "PSYCHOLOG")
Doctor.create(first_name: "MAKS", last_name: "PARADYS", faculty: "ORTOPEDA")
Doctor.create(first_name: "BOŻENA", last_name: "LUBICZ", faculty: "UROLOG")
Doctor.create(first_name: "MARTA", last_name: "GESLAR", faculty: "GASTROLOG")
