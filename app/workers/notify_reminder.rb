# frozen_string_literal: true

# This worker is responsible for sending reminders to users at Discord.
class NotifyReminder
  include Sidekiq::Worker
  # sidekiq_options queue: 'notify-reminder'

  def perform
    actual_date = Date.current
    actual_hour = Time.current.strftime('%H:%M')
    @reminders = Reminder.where("schedule->>'time' = ?", actual_hour).where(active: true)
    @reminders.each do |reminder|
      if reminder.schedule['frequence'].to_i == Reminder::FREQUENCE[:daily] ||
         reminder.schedule['frequence'].to_i == Reminder::FREQUENCE[:weekly]
        days = reminder.schedule['days']
        if days.include?(actual_date.wday.to_s)
          message = reminder.message
          reminder_service.send_reminder(message)
        end
      else
        date = reminder.schedule['day']
        if date == actual_date.day.to_s
          message = reminder.message
          reminder_service.send_reminder(message)
        end
      end
    end
  end

  def reminder_service
    @reminder_service ||= ReminderService.new
  end
end
