# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Burndown.create(
  date_start: '2021-10-15',
  date_end: '2021-10-29',
  sprint: 21,
  metascore: 30,
  created_at: DateTime.now.to_s,
  updated_at: DateTime.now.to_s
)
