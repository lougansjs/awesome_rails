# frozen_string_literal: true

# == RemindersController
class RemindersController < ApplicationController
  def index
    @reminders = Reminder.all
    @reminder = Reminder.new
    @frequence = @reminder.frequence
    @days = @reminder.days
  end

  def show; end

  def new
    @reminder = Reminder.new
  end

  def edit; end

  def schedule_by_frequence(attributes)
    reminder_service.schedule_by_frequence(attributes)
  end

  def create
    attributes = reminder_params
    schedule = schedule_by_frequence(attributes)
    @reminder = Reminder.new
    @reminder.name = attributes[:name]
    @reminder.message = attributes[:description]
    @reminder.schedule = schedule
    @reminder.active = true

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to reminders_url, notice: 'Reminder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def reminder_params
    params.permit(:name, :description, :frequence, :time, :date, days: [])
  end

  def reminder_service
    @reminder_service ||= ReminderService.new
  end
end
