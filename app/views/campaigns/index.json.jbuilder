json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :name, :has_many
  json.url campaign_url(campaign, format: :json)
end
