# coding: utf-8

User.create!(name: "管理者",
             email: "sample@email.com",
             department: "管理部",
             password: "password",
             password_confirmation: "password",
             admin: true)

2.times do |n|
  name = Faker::Name.name
  email = "superior-#{n+1}@email.com"
  department = "営業部長"
  password = "password"
  superior = true
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               department: department,
               superior: superior)
end
             
60.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
puts "Sample users created!"
