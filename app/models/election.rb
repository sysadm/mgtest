class Election < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :candidate
  validates :candidate_id, uniqueness: { scope: [:campaign_id] }
  has_many :votes
end
