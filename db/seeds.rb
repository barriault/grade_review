# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

term = Term.create(code: "201312", name: "Spring 2013", probation_term: "Fall 2013", active: true)
Term.create(code: "201322", name: "Summer 2013", probation_term: "Fall 2013", active: true)

user = User.create(name: "Jeff Barriault", uid: "barriauj", email: "barriauj@tamug.edu")
user.add_role :admin
user.save

user = User.create(name: "Donna Lang", uid: "langd", email: "langd@tamug.edu")
user.add_role :super_user
user.save

user = User.create(name: "Martin Miller", uid: "martin_miller", email: "martin_miller@tamu.edu")
user.add_role :mare
user.add_role :mase
user.save

user = User.create(name: "Augusta Roth", uid: "rotha", email: "rotha@tamug.edu")
user.add_role :mart
user.save

user = User.create(name: "Joan Mileski", uid: "mileskij", email: "mileskij@tamug.edu")
user.add_role :mara
user.add_role :mart
user.save

Student.create(initial_status: "Probation Level 1", uin: "422005388", major: "MARB", classification: "U1", first_name: "Jeff", last_name: "Barriault", email: "barriauj@tamug.edu", address_1: "720 Marlin Street", city: "Bayou Vista", state: "TX", postal_code: "77563", emailed: false, term: term)
               
Student.create(initial_status: "Probation Level 1", uin: "422005388", major: "MARF", classification: "U1", first_name: "Susan B.", last_name: "Anthony", email: "barriauj@tamug.edu", address_1: "17 Madison Street", city: "Rochester", state: "NY", postal_code: "14608", emailed: false, term: term)
               
Student.create(initial_status: "Probation Level 1", uin: "422005388", major: "MARB", classification: "U1", first_name: "Thomas", last_name: "Jefferson", email: "barriauj@tamug.edu", address_1: "931 Thomas Jefferson Parkway", city: "Charlottesville", state: "VA", postal_code: "22902", emailed: false, term: term)
               
Student.create(initial_status: "Suspension", uin: "422005388", major: "MARS", classification: "U1", first_name: "Jeff", last_name: "Barriault", email: "barriauj@tamug.edu", address_1: "720 Marlin Street", city: "Bayou Vista", state: "TX", postal_code: "77563", emailed: false, term: term)

Student.create(initial_status: "Suspension", uin: "422005388", major: "MART", classification: "U1", first_name: "John", last_name: "Adams", email: "barriauj@tamug.edu", address_1: "135 Adams Street", address_2: "Apt. 1B", city: "Quincy", state: "MA", postal_code: "02169", emailed: false, term: term)
