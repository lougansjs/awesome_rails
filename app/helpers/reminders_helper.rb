# frozen_string_literal: true

# RemindersHelper
module RemindersHelper
  def get_reminder_type(type)
    case type
    when '0'
      'Diário'
    when '1'
      'Semanal'
    when '2'
      'Mensal'
    end
  end
end
