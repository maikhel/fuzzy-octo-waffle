# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

faculty = Faculty.create(name: 'Wydział Matematyczno-Przyrodniczy')

field1 = FieldOfStudy.create(
  title: 'Informatyka',
  mode: 'full_time',
  degree: 'first_cycle',
  faculty: faculty
)

field2 = FieldOfStudy.create(
  title: 'Chemia',
  mode: 'full_time',
  degree: 'first_cycle',
  faculty: faculty
)

semester1 = Semester.create(start_date: Date.parse('01.10.2016'), end_date: Date.parse('14.02.2017'))
field1.semesters << semester1

semester2 = Semester.create(start_date: Date.parse('01.10.2016'), end_date: Date.parse('14.02.2017'))
field2.semesters << semester2

semester1.subjects << Subject.create(title: 'Programowanie obiektowe', short_description: 'Programowanie obiektowe')
semester1.subjects << Subject.create(title: 'Inżynieria oprogramowania', short_description: 'Inżynieria oprogramowania')
semester1.subjects << Subject.create(title: 'Matematyka dyskretna', short_description: 'Matematyka dyskretna')
semester1.subjects << Subject.create(title: 'Bazy danych', short_description: 'Bazy danych')
semester1.subjects << Subject.create(title: 'Grafika komputerowa', short_description: 'Grafika komputerowa')

30.times do
  Student.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    index_num: Faker::Number.number(6)
  )
end

puts 'Seeds created successfuly'
