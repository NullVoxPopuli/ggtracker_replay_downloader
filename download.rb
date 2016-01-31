# setup instructions:
#  - Have ruby and bundler installed
#  - gem install curb
#
# running instructions:
# in the terminal:
#   ruby ggtracker-download.rb

require 'curb'
require 'json'
require 'pry-byebug'

@folder_name = folder_name = 'ggtracker-replays'
puts 'replays will be saved in the "' + folder_name + '" folder'

def download_replay(url)
  puts "downloading replay from #{url}"

  Curl::Easy.download(url, filename = "#{@folder_name}/#{url.split(/\?/).first.split(/\//).last}")
end

def get_all_replay_s3_links_for_identity(identity = 4914, limit_to = 700)
  puts 'downloading replay data from ggtracker...'
  url = "http://api.ggtracker.com/api/v1/matches?category=Ladder&limit=#{limit_to}&game_type=1v1&identity_id=#{identity}&replay=true&filter=-graphs,match(replays,-map,-map_url),entity(-summary,-minutes,-armies)"

  puts 'making a request to ' + url
  c = Curl::Easy.perform(url)
  json = JSON.parse(c.body_str)
  replays = json['collection']
  s3_liks = replays.map do |replay_info|
    replay_info['replays'].map{|r| r['url'] }
  end

  s3_links.flatten
end


# make sure the download directory exists
unless File.directory?(folder_name)
  Dir.mkdir folder_name
end

links = get_all_replay_s3_links_for_identity
if links.count > 0
  puts "there are #{links.count} to download..."
  links.each do |url|
    download_replay(url)
  end

  puts 'done!'
else
  puts "there are noreplays to download"
end
