# frozen_string_literal: true

# ReminderService
class ReminderService
  def send_reminder(message)
    # Send a message to Discord.
    return if message.blank?

    Discord::Notifier.message(message)
  end

  def schedule_by_frequence(attributes)
    case attributes[:frequence].to_i
    when Reminder::FREQUENCE[:daily]
      schedule = { frequence: attributes[:frequence], time: attributes[:time],
                   days: attributes[:days] }
    when Reminder::FREQUENCE[:weekly]
      schedule = { frequence: attributes[:frequence], time: attributes[:time],
                   days: attributes[:days] }
    when Reminder::FREQUENCE[:monthly]
      schedule = { frequence: attributes[:frequence], time: attributes[:time],
                   day: attributes[:date] }
    end
    schedule
  end
end
