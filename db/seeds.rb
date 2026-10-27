[ Notification, Review, Report, Favorite, Tag, Application, Preference, Listing, User, Article ].each(&:delete_all)

PASSWORD = "123456"

User.create!(name: "Администратор", email: "admin@roomatch.ru", password: "admin123", admin: true)

User.create!(name: "Денис", email: "denis@roomatch.ru", password: PASSWORD)

polina = User.create!(
  name: "Полина", email: "polina@roomatch.ru", password: PASSWORD, age: 22, city: "Москва",
  occupation: "Студентка, дизайн", budget: 30000,
  about: "Учусь на дизайнера, по вечерам рисую. Люблю порядок и спокойные вечера."
)
maxim = User.create!(
  name: "Максим", email: "maxim@roomatch.ru", password: PASSWORD, age: 27, city: "Москва",
  occupation: "Frontend-разработчик", budget: 35000,
  about: "Работаю из дома 2–3 дня в неделю, поэтому важна тишина днём."
)
ilya = User.create!(
  name: "Илья", email: "ilya@roomatch.ru", password: PASSWORD, age: 24, city: "Санкт-Петербург",
  occupation: "Бариста", budget: 22000,
  about: "Работаю посменно, иногда возвращаюсь поздно. Готовлю отличный кофе для соседей."
)
katya = User.create!(
  name: "Катя", email: "katya@roomatch.ru", password: PASSWORD, age: 20, city: "Москва",
  occupation: "Студентка, медицина", budget: 25000,
  about: "Много учусь, рано встаю. Есть кошка Муся — очень спокойная."
)
dasha = User.create!(
  name: "Даша", email: "dasha@roomatch.ru", password: PASSWORD, age: 25, city: "Москва",
  occupation: "Маркетолог", budget: 28000,
  about: "Люблю готовить и звать друзей на ужин раз в пару недель."
)
oleg = User.create!(
  name: "Олег", email: "oleg@roomatch.ru", password: PASSWORD, age: 30, city: "Санкт-Петербург",
  occupation: "Инженер", budget: 25000,
  about: "Спокойный, не курю, часто в командировках."
)
sonya = User.create!(
  name: "Соня", email: "sonya@roomatch.ru", password: PASSWORD, age: 23, city: "Казань",
  occupation: "Фотограф", budget: 18000,
  about: "Переезжаю в Казань, ищу дружелюбных соседей и уютную квартиру."
)
artem = User.create!(
  name: "Артём", email: "artem@roomatch.ru", password: PASSWORD, age: 26, city: "Москва",
  occupation: "Аналитик данных", budget: 27000,
  about: "Днём в офисе, вечером спортзал. Готовлю на неделю вперёд и не против делиться."
)

[
  [ polina, 30000, false, true,  "высокая", "сова",      "иногда", "тишина",   "иногда", true,  true  ],
  [ maxim, 35000, false, false, "высокая", "жаворонок", "редко",  "тишина",   "не пью", true,  false ],
  [ ilya,  22000, true,  true,  "средняя", "свободный", "часто",  "не важно", "часто",  false, true  ],
  [ katya, 25000, false, true,  "высокая", "жаворонок", "редко",  "тишина",   "не пью", false, true  ],
  [ dasha, 28000, false, false, "средняя", "сова",      "часто",  "умеренно", "иногда", false, true  ],
  [ oleg,  25000, false, false, "средняя", "жаворонок", "редко",  "умеренно", "иногда", false, false ],
  [ sonya, 18000, false, true,  "низкая",  "свободный", "иногда", "не важно", "иногда", true,  true  ],
  [ artem, 27000, false, false, "высокая", "жаворонок", "иногда", "умеренно", "иногда", false, true  ]
].each do |user, budget, smoking, pets, cleanliness, schedule, guests, noise, alcohol, remote_work, shared_food|
  Preference.create!(user: user, budget: budget, smoking: smoking, pets: pets, cleanliness: cleanliness,
                     schedule: schedule, guests: guests, noise: noise, alcohol: alcohol,
                     remote_work: remote_work, shared_food: shared_food)
end

listing1 = Listing.create!(
  user: polina, title: "Ищу двух соседей в трёхкомнатную квартиру", city: "Москва",
  description: "Ищу спокойных соседей для совместной аренды. Важно поддерживать чистоту и заранее обсуждать бытовые вопросы.",
  rent: 30000, rooms: 3, max_people: 3, status: "active",
  tag_names: "рядом с метро, можно с животными, не курить"
)
listing2 = Listing.create!(
  user: maxim, title: "Нужен сосед рядом с метро", city: "Москва",
  description: "Ищу одного человека для совместной аренды. Квартира светлая, рядом магазины и метро.",
  rent: 25000, rooms: 2, max_people: 2, status: "active",
  tag_names: "рядом с метро, тихий район, без животных"
)
listing3 = Listing.create!(
  user: ilya, title: "Ищу соседей для большой квартиры", city: "Санкт-Петербург",
  description: "Снимаем большую квартиру в центре, нас уже двое, ищем ещё двух человек. Хотим жить в спокойной атмосфере.",
  rent: 22000, rooms: 4, max_people: 4, status: "active",
  tag_names: "центр, можно с животными, большая кухня"
)
listing4 = Listing.create!(
  user: dasha, title: "Комната в квартире с балконом", city: "Москва",
  description: "Свободна одна комната. В квартире есть посудомойка и большой балкон.",
  rent: 28000, rooms: 2, max_people: 2, status: "active", active_until: Date.current + 30,
  tag_names: "балкон, посудомойка"
)
listing5 = Listing.create!(
  user: oleg, title: "Сосед на время командировок", city: "Санкт-Петербург",
  description: "Часто уезжаю, квартира почти всегда в вашем распоряжении. Нужен аккуратный человек.",
  rent: 20000, rooms: 2, max_people: 2, status: "closed",
  tag_names: "тихий район, не курить"
)
listing6 = Listing.create!(
  user: sonya, title: "Ищу соседку в Казани", city: "Казань",
  description: "Переезжаю в Казань, хочу снять двушку вместе с девушкой-соседкой.",
  rent: 18000, rooms: 2, max_people: 2, status: "active", active_until: Date.current + 60,
  tag_names: "только девушки, можно с животными"
)
listing7 = Listing.create!(
  user: katya, title: "Ищу соседку рядом с медуниверситетом", city: "Москва",
  description: "Снимаю двушку в 10 минутах от университета. Вторая комната свободна с декабря. Живу с кошкой, рано встаю, по вечерам тихо.",
  rent: 26000, rooms: 2, max_people: 2, status: "active", active_until: Date.current + 45,
  tag_names: "рядом с метро, можно с животными, для студентов"
)
listing8 = Listing.create!(
  user: artem, title: "Квартира у парка, ищем третьего", city: "Москва",
  description: "Живём вдвоём с Дашей в трёшке у парка. Ищем третьего соседа: спокойного и аккуратного.",
  rent: 24000, rooms: 3, max_people: 3, status: "active",
  tag_names: "рядом с парком, большая кухня, не курить"
)

Application.create!(user: katya, listing: listing1, status: "accepted",
                    message: "Привет! Мне подходит ваш вариант. У меня спокойная кошка — надеюсь, это не проблема.")
Application.create!(user: maxim, listing: listing1, status: "pending",
                    message: "Работаю из дома, веду себя тихо. Готов к встрече.")
Application.create!(user: dasha, listing: listing2, status: "rejected",
                    message: "Здравствуйте! Интересует ваше объявление. Когда можно обсудить детали?")
Application.create!(user: oleg, listing: listing3, status: "accepted",
                    message: "Добрый день! Готов посмотреть квартиру в выходные.")
Application.create!(user: polina, listing: listing4, status: "pending",
                    message: "Привет! Очень нравится вариант с балконом, давай созвонимся?")
Application.create!(user: dasha, listing: listing8, status: "accepted",
                    message: "Артём, привет! Как договаривались — я в деле.")
Application.create!(user: sonya, listing: listing7, status: "pending",
                    message: "Катя, привет! Я тоже обожаю кошек. Можно посмотреть квартиру?")

Favorite.create!(user: polina, listing: listing2)
Favorite.create!(user: polina, listing: listing8)
Favorite.create!(user: katya, listing: listing4)
Favorite.create!(user: oleg,  listing: listing3)
Favorite.create!(user: sonya, listing: listing1)
Favorite.create!(user: dasha, listing: listing7)

Review.create!(author: katya, recipient: polina, rating: 5, text: "Полина очень аккуратная и приятная в общении.")
Review.create!(author: maxim, recipient: polina, rating: 4, text: "Быстро отвечает, всё обсудили заранее.")
Review.create!(author: polina, recipient: maxim, rating: 5, text: "Максим ответственный, всегда платит вовремя.")
Review.create!(author: oleg,  recipient: ilya,  rating: 4, text: "Весёлый сосед, но иногда шумно по ночам.")
Review.create!(author: ilya,  recipient: oleg,  rating: 5, text: "Идеальный сосед — тихий и чистоплотный.")
Review.create!(author: dasha, recipient: katya, rating: 5, text: "Катя — чудо, а её кошка ещё лучше.")
Review.create!(author: polina, recipient: dasha, rating: 4, text: "Вкусно готовит и всегда делится!")
Review.create!(author: dasha, recipient: artem, rating: 5, text: "С Артёмом спокойно: чисто, тихо, всё по договорённости.")
Review.create!(author: katya, recipient: sonya, rating: 3, text: "Хорошая, но не всегда убирает за собой.")

Report.create!(user: katya, listing: listing5, reason: "Неактуальное объявление",
               description: "Владелец сказал, что уже нашёл соседа.", status: "reviewed")
Report.create!(user: polina, listing: listing3, reason: "Неверная цена",
               description: "В объявлении указана одна цена, а по телефону назвали другую.", status: "new")

Notification.create!(user: polina, text: "Катя откликнулась на ваше объявление «#{listing1.title}»", read: true)
Notification.create!(user: polina, text: "Максим откликнулся на ваше объявление «#{listing1.title}»")
Notification.create!(user: polina, text: "Вам оставили новый отзыв")
Notification.create!(user: maxim, text: "Даша откликнулась на ваше объявление «#{listing2.title}»", read: true)
Notification.create!(user: oleg,  text: "Ваш отклик на «#{listing3.title}» приняли!")
Notification.create!(user: dasha, text: "Полина откликнулась на ваше объявление «#{listing4.title}»")
Notification.create!(user: katya, text: "Соня откликнулась на ваше объявление «#{listing7.title}»")

articles = [
  {
    title: "Как найти соседа и не пожалеть: 7 шагов",
    category: "Советы",
    summary: "Пошаговая инструкция — от объявления до подписания договора.",
    body: <<~TEXT
      Поиск соседа похож на собеседование: вы выбираете человека, с которым будете делить кухню, ванную и тишину по вечерам.

      1. Честно опишите себя и квартиру. Чем точнее объявление, тем меньше случайных откликов.
      2. Заполните предпочтения в профиле: курение, животные, график, отношение к чистоте.
      3. Посмотрите рейтинг и отзывы о кандидате.
      4. Познакомьтесь вживую или по видеосвязи до переезда.
      5. Обсудите деньги: аренду, коммуналку, интернет и общие покупки.
      6. Договоритесь о правилах быта заранее.
      7. Зафиксируйте договорённости письменно.
    TEXT
  },
  {
    title: "Правила общей квартиры: о чём договориться в первый день",
    category: "Быт",
    summary: "Уборка, гости, тишина и общие продукты — темы, которые лучше обсудить сразу.",
    body: <<~TEXT
      Большинство конфликтов между соседями возникает не из-за плохого характера, а из-за несовпадения ожиданий.

      Обсудите график уборки: кто и когда моет общие зоны. Удобно составить таблицу и повесить её на холодильник.

      Договоритесь о гостях: можно ли приводить друзей с ночёвкой и как часто.

      Определите «часы тишины», особенно если один из вас жаворонок, а другой сова.

      Решите, какие продукты общие, а какие у каждого свои.
    TEXT
  },
  {
    title: "Как честно делить аренду и коммунальные платежи",
    category: "Деньги",
    summary: "Поровну, по площади комнат или по доходу — разбираем варианты.",
    body: <<~TEXT
      Самый простой способ — делить всё поровну. Он подходит, если комнаты примерно одинаковые.

      Если одна комната заметно больше или с балконом, справедливее делить аренду пропорционально площади.

      Коммунальные платежи обычно делят поровну, а интернет и общие покупки — по договорённости.

      Совет: заведите общую заметку или таблицу расходов, чтобы никто не держал суммы в голове.
    TEXT
  },
  {
    title: "Соседство с животными: что нужно обсудить",
    category: "Советы",
    summary: "Кошка, собака или попугай — как жить вместе и не поссориться.",
    body: <<~TEXT
      Указывайте в объявлении и предпочтениях, есть ли у вас питомец или вы не против животных.

      Обсудите аллергию, шерсть, запахи и то, кто убирает лоток или гуляет с собакой.

      Уточните у арендодателя, разрешены ли животные в квартире — это часто прописано в договоре.
    TEXT
  },
  {
    title: "Красные флаги в объявлениях о поиске соседей",
    category: "Безопасность",
    summary: "Признаки того, что с объявлением что-то не так.",
    body: <<~TEXT
      Будьте осторожны, если:

      — цена заметно ниже рынка, а фото выглядят как из каталога;
      — автор просит перевести предоплату до просмотра;
      — нет возможности встретиться лично или созвониться по видео;
      — у пользователя пустой профиль и нет отзывов.

      Если объявление кажется подозрительным, отправьте жалобу — модераторы Roomatch её проверят.
    TEXT
  },
  {
    title: "Как Roomatch подбирает соседей",
    category: "О сервисе",
    summary: "Рассказываем, зачем нужны предпочтения, теги и рейтинг.",
    body: <<~TEXT
      Roomatch помогает найти не просто квартиру, а людей, с которыми комфортно жить.

      Предпочтения в профиле показывают ваш образ жизни: график, отношение к курению, животным и чистоте.

      Теги в объявлениях помогают быстро понять главное: «рядом с метро», «можно с животными», «для студентов».

      Рейтинг складывается из отзывов бывших соседей. Чем больше хороших отзывов, тем выше доверие к пользователю.
    TEXT
  }
]

articles.each_with_index do |attrs, index|
  Article.create!(attrs.merge(created_at: (articles.size - index).days.ago))
end

puts "Пользователей: #{User.regular.count} + администраторов: #{User.where(admin: true).count}"
puts "Объявлений: #{Listing.count}, тегов: #{Tag.count}"
puts "Откликов: #{Application.count}, в избранном: #{Favorite.count}"
puts "Отзывов: #{Review.count}, жалоб: #{Report.count}"
puts "Предпочтений: #{Preference.count}, уведомлений: #{Notification.count}"
puts "Статей: #{Article.count}"
puts
puts "Вход (пустой профиль):    denis@roomatch.ru / #{PASSWORD}"
puts "Вход (заполненный):       polina@roomatch.ru / #{PASSWORD}"
puts "Вход для админа:          admin@roomatch.ru / admin123"
