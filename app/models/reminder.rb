# frozen_string_literal: true

# Reminder model
class Reminder < ApplicationRecord
  FREQUENCE = {
    daily: 0,
    weekly: 1,
    monthly: 2
  }.freeze

  DAYS = {
    sunday: [0, 'Domingo'],
    monday: [1, 'Segunda-feira'],
    tuesday: [2, 'Terça-feira'],
    wednesday: [3, 'Quarta-feira'],
    thursday: [4, 'Quinta-feira'],
    friday: [5, 'Sexta-feira'],
    saturday: [6, 'Sábado']
  }.freeze

  def frequence
    options = []
    FREQUENCE.each do |key, value|
      options << ['Diário', value] if key.to_s == 'daily'
      options << ['Semanal', value] if key.to_s == 'weekly'
      options << ['Mensal', value] if key.to_s == 'monthly'
    end
    options
  end

  def days
    options = []
    DAYS.each do |_key, value|
      options << [value[1][0..2], value[0]]
    end
    options
  end
end
