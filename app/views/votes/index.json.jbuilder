json.array!(@votes) do |vote|
  json.extract! vote, :id, :vote_time, :validity, :conn, :msisdn, :guid, :shortcode
  json.url vote_url(vote, format: :json)
end
