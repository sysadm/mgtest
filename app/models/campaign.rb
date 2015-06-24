class Campaign < ActiveRecord::Base
  has_many :candidates, through: :elections
  has_many :elections, dependent: :destroy
end
