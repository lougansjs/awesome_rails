# frozen_string_literal: true

# Este service e responsavel por chamar a API do Artia
class ArtiaService
  class QueryError < StandardError; end

  GenerateToken = SWAPI::Client.parse <<-'GRAPHQL'
    mutation($client_id: String!, $secret: String!){
      authenticationByClient(clientId: $client_id,secret: $secret){
        token
      }
    }
  GRAPHQL

  ListActivities = SWAPI::Client.parse <<-'GRAPHQL'
    query($folder_id: Int!){
      listingActivities(accountId: 1573596, folderId: $folder_id){
        id, title, status, actualEnd, folderTypeName, customStatus{ id }
      }
    }
  GRAPHQL

  SearchActivity = SWAPI::Client.parse <<-'GRAPHQL'
    query($id: ID!, $folder_id: Int!) {
      showActivity(id: $id, accountId: 1573596, folderId: $folder_id) {
        id, title, status, estimatedStart, estimatedEnd, actualEffort,
        actualEnd, customColumns, customStatus { id }
      }
    }
  GRAPHQL

  SearchTimeEntry = SWAPI::Client.parse <<-'GRAPHQL'
    query($activity_id: Int!, $folder_id: Int!) {
      listingTimeEntries(accountId: 1573596, folderId: $folder_id, activityId: $activity_id) {
        id, folderId, accountId, activityId, userId, dateAt, startTime,
        duration, endTime, timeEntryStatusId, registeredBy
      }
    }
  GRAPHQL

  ARTIA = 2_898_988
  TWYGO = 2_898_987
  FLEEG = 2_898_986

  FOLDERS = {
    artia: ARTIA,
    twygo: TWYGO,
    fleeg: FLEEG
  }.freeze

  IDS = [
    91, 105, 1940, 1943, 8069, 10_130, 26_017,
    26_018, 31_339, 136_419, 154_898, 1941,
    31_336, 31_338, 31_351, 31_356, 10_130
  ].freeze

  ACTIVITIES_TYPE = [
    '7 - Bug Produção', '11 - Solicitação de Serviço', '2 - Dúvida'
  ].freeze

  def initialize(list = true)
    @client_id = Rails.application.credentials[Rails.env.to_sym][:client_id_artia]
    @secret = Rails.application.credentials[Rails.env.to_sym][:secret_artia]
    @token = client_context
    @activities = search_activities if list
  end

  def query(definition, variables = {})
    response = SWAPI::Client.query(definition, variables: variables, context: @token)

    raise QueryError, response.errors[:data].join(', ') if response.errors.any?

    response.data
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def client_context
    {
      access_token: SWAPI::Client.query(
        GenerateToken,
        variables: { client_id: @client_id, secret: @secret }
      ).data.authentication_by_client.token
    }
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def search_activities
    list = []
    FOLDERS.keys.each do |folder|
      data = query(
        ListActivities, folder_id: FOLDERS[folder].to_i
      ).listing_activities

      list << data.map(&:to_h)
    end
    list.flatten
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def search_activity(id, app)
    query(SearchActivity, id: id, folder_id: FOLDERS[app]).show_activity.to_h
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def search_time_entries(activity_id, app)
    query(SearchTimeEntry, activity_id: activity_id, folder_id: FOLDERS[app])
      .listing_time_entries.map(&:to_h)
  end

  def concluded_activities
    @activities.select do |activity|
      next if activity['actualEnd'].nil?

      activity['status'] == true && [95].include?(activity['customStatus']['id'].to_i)
    end
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def filter_activities
    @activities.select do |activity|
      activity['status'] == false && IDS.include?(activity['customStatus']['id'].to_i)
    end
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def count_activities(dates)
    list = []
    dates = dates
    concluded = concluded_activities.select do |activity|
      activity['actualEnd'].to_date.between?(dates.first, dates.last) &&
        ACTIVITIES_TYPE.include?(activity['folderTypeName']&.to_s)
    end
    dates.each do |date|
      list << concluded.select { |activity| activity['actualEnd'].to_date == date }.count
    end
    list
  rescue StandardError => e
    Airbrake.notify(e)
  end
end
