require 'net/http'
require 'uri'
require 'json'


API_KEY = ''
champion_data_uri = URI.parse("http://ddragon.leagueoflegends.com/cdn/10.1.1/data/ja_JP/champion.json")
champion_data = Net::HTTP.get(champion_data_uri)
champions = JSON.parse(champion_data)


name = URI.encode("")
region = "jp"
uri = URI.parse("https://jp1.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{name}?api_key=#{API_KEY}")
return_data = Net::HTTP.get(uri)
summoner_data = JSON.parse(return_data)
summoner_id = summoner_data["id"]

mastery_uri = "https://jp1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner"
uri = URI.parse("#{mastery_uri}/#{summoner_id}/?api_key=#{API_KEY}")

return_data = Net::HTTP.get(uri)
mastery_data = JSON.parse(return_data)

champion_hash = champions["data"].map {|k,v| [v["key"], v["name"]] }.to_h

mastery_data.map { |k| p [champion_hash[k["championId"].to_s], k["championLevel"]] }