namespace :import do
  desc 'import votes from text file'
  task :votes => :environment do
    def parse_and_create_data(file)
      begin
        @errors = 0
        IO.foreach file do |line|
          parse_result = Vote.parse_vote_string line
          if parse_result
            campaign = Campaign.find_or_create_by(name: parse_result[:campaign])
            candidate = Candidate.find_or_create_by(name: parse_result[:candidate])
            campaign.candidates << candidate unless campaign.candidates.include? candidate
            election = Election.where(campaign: campaign, candidate: candidate)[0]
            Vote.create(
                vote_time: parse_result[:vote_time],
                validity: parse_result[:validity],
                election: election
            )
          else
            puts "Invalid string: #{line}"
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
