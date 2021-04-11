# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
profession1 = Profession.find_or_create_by(name: 'Teacher')
admin_role = Role.find_or_create_by(status: 'admin')
admin_user = User.find_or_create_by(email: 'admin@codechallenge.com', username: 'admin') do |user|
  user.password = "password123!"
end

UserRole.find_or_create_by(user_id: admin_user.id, role_id:admin_role.id)
admin_user_profession = UserProfession.find_or_create_by(user_id:admin_user.id, profession_id:profession1.id)
events = Event.find_or_create_by(description: "First day on the job", clock_in: "2021-04-11T00:00:00", user_profession: admin_user_profession)
events = Event.find_or_create_by(description: "A quick change", clock_in: "2021-04-11T08:00:00", clock_out: "2021-04-11T15:00:00", user_profession: admin_user_profession)
events = Event.find_or_create_by(description: "Ran off to get groceries", clock_in: "2021-04-11T00:00:00", user_profession: admin_user_profession)

staff_role = Role.find_or_create_by(status: 'staff')
user = User.find_or_create_by(email: 'staff@codechallenge.com', username: 'staff') do |user|
  user.password = "password123!"
end
UserRole.find_or_create_by(user_id:user.id, role_id:staff_role.id)
staff_user_profession = UserProfession.find_or_create_by(user_id:user.id, profession_id:profession1.id)
events = Event.find_or_create_by(description: "Ran off to get groceries", clock_in: "2021-04-11T00:00:00", user_profession: staff_user_profession)
events = Event.find_or_create_by(description: "Taking a quick nap", clock_in: "2021-04-11T08:00:00", clock_out: "2021-04-11T15:00:00", user_profession: staff_user_profession)


