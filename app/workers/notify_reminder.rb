# frozen_string_literal: true

# This worker is responsible for sending reminders to users at Discord.
class NotifyReminder
  include Sidekiq::Worker
  sidekiq_options queue: 'notify-reminder'

  def perform
    @reminders = Reminder.where(active: true)
    @reminders.each do |_reminder|
      actual_date = Date.current
      actual_hour = Time.current.strftime('%H:%M')
    end
  end
end
