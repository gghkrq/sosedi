# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Application.destroy_all
Listing.destroy_all
User.destroy_all

# Пользователи
anna = User.create!(
  name: "Анна",
  email: "anna@example.com"
)

maxim = User.create!(
  name: "Максим",
  email: "maxim@example.com"
)

ilya = User.create!(
  name: "Илья",
  email: "ilya@example.com"
)

katya = User.create!(
  name: "Катя",
  email: "katya@example.com"
)

dasha = User.create!(
  name: "Даша",
  email: "dasha@example.com"
)

# Заявки на поиск соседей
listing1 = Listing.create!(
  title: "Ищу двух соседей в трёхкомнатную квартиру",
  description: "Ищу спокойных соседей для совместной аренды. Важно поддерживать чистоту и заранее обсуждать бытовые вопросы.",
  city: "Москва",
  rent: 30000,
  rooms: 3,
  max_people: 3,
  user: anna
)

listing2 = Listing.create!(
  title: "Нужен сосед рядом с метро",
  description: "Ищу одного человека для совместной аренды. Квартира светлая, рядом магазины и метро.",
  city: "Москва",
  rent: 25000,
  rooms: 2,
  max_people: 2,
  user: maxim
)

listing3 = Listing.create!(
  title: "Ищу соседей для большой квартиры",
  description: "Планируем снять большую квартиру и ищем ещё двух человек. Хотим жить в спокойной атмосфере.",
  city: "Санкт-Петербург",
  rent: 22000,
  rooms: 4,
  max_people: 4,
  user: ilya
)

# Отклики
Application.create!(
  message: "Привет! Мне подходит ваш вариант. Могу рассказать немного о себе.",
  status: "pending",
  user: katya,
  listing: listing1
)

Application.create!(
  message: "Здравствуйте! Интересует ваша заявка. Когда можно обсудить детали?",
  status: "pending",
  user: dasha,
  listing: listing2
)

puts "Created #{User.count} users"
puts "Created #{Listing.count} listings"
puts "Created #{Application.count} applications"