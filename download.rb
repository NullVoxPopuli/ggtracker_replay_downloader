# setup instructions:
#  - Have ruby and bundler installed
#  - gem install curb
#
# running instructions:
# in the terminal:
#   ruby ggtracker-download.rb

require 'curb'
require 'json'

@folder_name = folder_name = 'ggtracker-replays'
puts 'replays will be saved in the "' + folder_name + '" folder'

def download_replay(id)
  puts "downloading replay: #{id}"
  url = "http://ggtracker.com/matches/#{id}/replay"

  Curl::Easy.download(url, filename = "#{@folder_name}/#{id}.SC2Replay")
end

def get_all_replay_ids_for_identity(identity = 4914, limit_to = 700)
  puts 'downloading replay data from ggtracker...'
  url = "http://api.ggtracker.com/api/v1/matches?category=Ladder&game_type=1v1&identity_id=#{identity}&replay=true&limit=#{limit_to}"

  c = Curl::Easy.perform(url)
  json = JSON.parse(c.body_str)
  replays = json['collection']
  ids = replays.map do |replay_info|
    replay_info['id']
  end

  ids
end


# make sure the download directory exists
unless File.directory?(folder_name)
  Dir.mkdir folder_name
end

replay_ids = get_all_replay_ids_for_identity
replay_ids.each do |id|
  download_replay(id)
end

puts 'done!'
