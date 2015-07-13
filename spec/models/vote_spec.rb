require 'rails_helper'

describe Vote do
  it 'return false for invalid strings with votes' do
    file = File.join(Rails.root, '/spec/fixtures/votes/incorrect_votes.txt')
    IO.foreach file do |line|
      expect(Vote.parse_vote_string line).to be_falsey
    end
  end
  it 'return hash for valid string with vote' do
    file = File.join(Rails.root, '/spec/fixtures/votes/correct_vote.txt')
    IO.foreach file do |line|
      parsed_vote = Vote.parse_vote_string line
      expect(parsed_vote).to have_key(:vote_time)
      expect(parsed_vote.count).to equal(4)
      expect(parsed_vote[:campaign]).to match("ssss_uk_02A")
    end
  end
end
