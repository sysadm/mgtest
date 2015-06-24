class Vote < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :campaign
  belongs_to :election

end
