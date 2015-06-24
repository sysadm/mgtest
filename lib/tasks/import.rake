namespace :import do
  desc 'import votes from text file'
  task :votes => :environment do
    def parse_and_create_data(file)
      begin
        ssv = File.open file, "r:UTF-8"
        @errors = 0
        File.readlines(ssv).map do |line|
          v = line.force_encoding("ISO-8859-1").encode("utf-8", replace: nil).split("\s")
          p line
          correct_line = (v.count == 9 && v[0] == "VOTE" && v[2].split(':')[0] == "Campaign" && !v[2].split(':')[1].blank? && v[3].split(':')[0] == "Validity" && v[4].split(':')[0] == "Choice")
          if correct_line
            campaign = Campaign.find_or_create_by(name: v[2].split(':')[1])
            candidate = Candidate.find_or_create_by(name: v[4].split(':')[1])
            campaign.candidates << candidate unless campaign.candidates.include? candidate
            election = Election.where(campaign: campaign, candidate: candidate)[0]
            validity = v[3].split(':')[1]
            Vote.create(
                vote_time: v[1].to_i,
                validity: validity,
                election: election
            )
          else
            @errors += 1
          end
        end
      rescue => e
        puts "Something went wrong. Error message: #{e.message}"
        return 1
      end
    end

    file = ENV['VOTES']
    begin
      input = File.open file
    rescue => e
      puts "Wrong filename or path"
      exit(1)
    end
    puts "Start import at: #{Time.now}"
    result = parse_and_create_data input
    puts "Finish import at: #{Time.now}"
    puts "Error count: #{@errors}"
    puts "Complete." unless result == 1
  end
end
