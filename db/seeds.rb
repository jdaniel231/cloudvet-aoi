# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.find_or_create_by!(email: 'test@test.com') do |user|
  user.password = '123456'
  user.password_confirmation = '123456'
end

5.times do |i|
  Client.find_or_create_by!(cpf: "1234567891#{i}") do |client|
    client.name = "client #{i}"
    client.rg = "12345678#{i}"
    client.phone = "1234567891#{i}"
    client.address = "address #{i}"
    client.number_address = "#{i}"
    client.compl_address = "compl address #{i}"
    client.neighborhoods = "neighborhoods #{i}"
    client.user_id = user.id
  end
end