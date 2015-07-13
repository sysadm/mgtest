class Vote < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :campaign
  belongs_to :election

  def self.parse_vote_string(str)
    #v = str.force_encoding("ISO-8859-1").encode("utf-8", replace: nil).split("\s")
    begin
      v = str.split("\s")
    rescue => e
      puts "Something went wrong, string ignored. Error message: #{e.message}"
      return false
    end
    if v.count == 9
      campaign = v[2].split(':')
      validity = v[3].split(':')
      choice = v[4].split(':')
      conn = v[5].split(':')
      msisdn = v[6].split(':')
      guid = v[7].split(':')
      shortcode = v[8].split(':')
    else
      return false
    end
    if v[0] == "VOTE" && v[1].is_numeric? && campaign[0] == "Campaign" && !campaign[1].blank? && validity[0] == "Validity" && %w(pre during post).include?(validity[1]) && choice[0] == "Choice" && conn[0] == "CONN" && msisdn[0] == "MSISDN" && msisdn[1].is_numeric? && guid[0] == "GUID" && shortcode[0] == "Shortcode" && shortcode[1].is_numeric?
      return {vote_time: v[1].to_i, validity: validity[1], campaign: campaign[1], candidate: choice[1]}
    else
      return false
    end
  end
end
