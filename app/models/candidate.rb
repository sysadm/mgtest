class Candidate < ActiveRecord::Base
  has_many :campaign, through: :elections
  has_many :elections


  def votes_counted_in_campaign(campaign)
    self.elections.where(campaign: campaign).first.votes.where(validity: 'during').count
  end
  def votes_not_counted_in_campaign(campaign)
    votes = self.elections.where(campaign: campaign).first.votes
    votes.count - votes.where(validity: 'during').count
  end
end
