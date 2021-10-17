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

  def search_activities_artia
    Net::HTTP.start(@url.host, @url.port, use_ssl: @url.scheme == 'https') do |http|
      request = Net::HTTP::Post.new(@url)
      request['OrganizationId'] = '211'
      request['Authorization'] = "Bearer #{@token}" if @token.present?
      request['Content-Type'] = 'application/json'
      request.body = select_request('activities')
      response = http.request(request)
      JSON.parse(response.body)['data']['listingActivities']
    end
  end

  def filter_activities_artia
    search_activities_artia.select do |activity|
      activity['status'] == false && IDS.include?(activity['customStatus']['id'].to_i)
    end
  end

  def select_request(identifier)
    case identifier
    when 'token'
      '{"query":"mutation{authenticationByClient(clientId: \\"de2d5d48c6a78a35766bf1ba443414419213c6efe42b77c1030ae401a470c967\\",secret: \\"a2e44a4272f3a54b5b8a62da901188f6f2d1cc99cc8d6ada260a5fc9de3c5578\\"){token}}","variables":{}}'
    when 'activities'
      '{"query":"query{listingActivities(accountId: 1573596, folderId: 2898988) {id, title, status, customStatus{id}}}","variables":{}}'
    when 'update_situation'
      '{"query":"mutation{changeCustomStatusActivity(id: 1, accountId: 1, folderId: 1, customStatusId: 104, status: false){id}}","variables":{}}'
    end
  end
end
# //Concluída
# 95

# CustomStatus.where(status_object: "Activity", status: false, organization_id: 211).where(id: [91, 105, 1940, 1943, 8069, 10130, 26017, 26018, 31339, 136419, 154898, 1941, 31336, 31338, 31351, 31356, 10130])

# activities.where(status: false, custom_status_id: cs.pluck(:id))

# //REGRAS
# O burndown começa no dia da planning
# A meta definida é 30
# Todo dia ele verifica que atividades foram concluídas
# nesse dia onde o término real é igual ao dia atual.
