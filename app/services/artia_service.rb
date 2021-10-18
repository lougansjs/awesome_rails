# frozen_string_literal: true

# Este service e responsavel por chamar a API do Artia
class ArtiaService
  IDS = [
    91, 105, 1940, 1943, 8069, 10_130, 26_017,
    26_018, 31_339, 136_419, 154_898, 1941,
    31_336, 31_338, 31_351, 31_356, 10_130
  ].freeze

  def initialize
    @url = URI('https://app.artia.com/graphql')
    @client_id = Rails.application.credentials[Rails.env.to_sym][:client_id_artia]
    @secret = Rails.application.credentials[Rails.env.to_sym][:secret_artia]
    @token = request_token
    @activities = search_activities
  end

  def request_token
    Net::HTTP.start(@url.host, @url.port, use_ssl: @url.scheme == 'https') do |http|
      request = Net::HTTP::Post.new(@url)
      request['Content-Type'] = 'application/json'
      request.body = select_request('token')
      response = http.request(request)
      JSON.parse(response.body)['data']['authenticationByClient']['token'].to_s
    end
  end

  def search_activities
    list = []
    %w[activities-artia activities-twygo activities-fleeg].each do |query|
      Net::HTTP.start(@url.host, @url.port, use_ssl: @url.scheme == 'https') do |http|
        request = Net::HTTP::Post.new(@url)
        request['OrganizationId'] = '211'
        request['Authorization'] = "Bearer #{@token}" if @token.present?
        request['Content-Type'] = 'application/json'
        request.body = select_request(query)
        response = http.request(request)
        list << JSON.parse(response.body)['data']['listingActivities']
      end
    end
    list.flatten
  end

  def filter_activities
    @activities.select do |activity|
      activity['status'] == false && IDS.include?(activity['customStatus']['id'].to_i)
    end
  end

  def concluded_activities
    @activities.select do |activity|
      next if activity['actualEnd'].nil?

      activity['status'] == true && [95].include?(activity['customStatus']['id'].to_i)
    end
  end

  def count_activities(dates)
    list = []
    dates = dates.reject(&:today?)
    concluded = concluded_activities.select { |activity| activity['actualEnd'].to_date.between?(dates.first, dates.last) }
    dates.each do |_date|
      list << concluded.select { |activity| activity['actualEnd'].to_date == _date }.count
    end
    list
  end

  def select_request(identifier)
    case identifier
    when 'token'
      '{"query":"mutation{authenticationByClient(clientId: \\"de2d5d48c6a78a35766bf1ba443414419213c6efe42b77c1030ae401a470c967\\",secret: \\"a2e44a4272f3a54b5b8a62da901188f6f2d1cc99cc8d6ada260a5fc9de3c5578\\"){token}}","variables":{}}'
    when 'activities-artia'
      '{"query":"query{listingActivities(accountId: 1573596, folderId: 2898988) {id, title, status, actualEnd, customStatus{id}}}","variables":{}}'
    when 'activities-twygo'
      '{"query":"query{listingActivities(accountId: 1573596, folderId: 2898987) {id, title, status, actualEnd, customStatus{id}}}","variables":{}}'
    when 'activities-fleeg'
      '{"query":"query{listingActivities(accountId: 1573596, folderId: 2898986) {id, title, status, actualEnd, customStatus{id}}}","variables":{}}'
    when 'update_situation'
      '{"query":"mutation{changeCustomStatusActivity(id: 1, accountId: 1, folderId: 1, customStatusId: 104, status: false){id}}","variables":{}}'
    end
  end
end
