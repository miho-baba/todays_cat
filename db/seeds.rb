# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ユーザーの記述
Admin.create(email: 'admin@admin', password: 'abcdef')

# 会員の記述
Customer.create(email: 'neko@gmail.com', password: 'nekoneko', last_name: '田中', first_name: '花子', last_name_kana: 'タナカ', first_name_kana: 'ハナコ', phone_number: '2525252525')

# 他の会員の記述
other_customers = [
  { email: 'nk@gmail.com', password: 'samasama', last_name: '佐藤', first_name: '一郎', last_name_kana: 'サトウ', first_name_kana: 'イチロウ', phone_number: '2121212121' },
  { email: 'nn@gmail.com', password: 'kokokoko', last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', phone_number: '5252525252' },
]
Customer.create(other_customers)
