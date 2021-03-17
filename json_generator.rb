# frozen_string_literal: true

require 'csv'
require 'gruff'
require 'json'
require './ipl'

# Reading the file
deliveries_file = CSV.parse(File.read('deliveries.csv'), headers: true)
matches_file = CSV.parse(File.read('matches.csv'), headers: true)
umpires_file = CSV.parse(File.read('umpires.csv'), headers: true)

# Rewrite Supergiant when find Supergiants
(0..matches_file.length - 1).each do |i|
  matches_file[i][4] = 'Rising Pune Supergiant' if matches_file[i][4] == 'Rising Pune Supergiants'
  # we need only 4th column but we should overwrite all the values
  matches_file[i][5] = 'Rising Pune Supergiant' if matches_file[i][5] == 'Rising Pune Supergiants'
  matches_file[i][6] = 'Rising Pune Supergiant' if matches_file[i][6] == 'Rising Pune Supergiants'
  matches_file[i][10] = 'Rising Pune Supergiant' if matches_file[i][10] == 'Rising Pune Supergiants'
end

(0..deliveries_file.length - 1).each do |i|
  deliveries_file[i][2] = 'Rising Pune Supergiant' if deliveries_file[i][2] == 'Rising Pune Supergiants'
end

obj = Ipl.new
# ====================================================================================
# 1. Solution For Problem One
# ====================================================================================

# Find all team names and store only one occurance of each team in @team_hash from matches_file
team = obj.unique_team(matches_file)

# sum the tot_run and store in @teamrun_hash with team name
teamrun = obj.count_team_run(team, deliveries_file)

# Generate Json file by the help of hash
File.open('json/team_run.json', 'w') do |f|
  f.write(teamrun.to_json)
end

# ====================================================================================
# 2. Solution For Problem Two
# ====================================================================================

# find all RCB players name and make one occurance and store in @rcb_players_hash
rcb_players = obj.players_name(deliveries_file)

# sum the total score of each player of RCB in IPL and store it in @rcb_run_hash with their name
rcb_run = obj.players_run(rcb_players, deliveries_file)

# sort by value and store in the same hash in Descending Order for top players of rcb by run
rcb_run = rcb_run.sort_by { |_key, value| value }.reverse.to_h

# get top 10 batsman of rcb
top_rcb = {}
no_of_top_batsman = 10
rcb_run.each_with_index do |(k, v), i|
  top_rcb[k] = v if i < no_of_top_batsman
  break if i == no_of_top_batsman
end

# Generate Json file by the help of hash
File.open('json/rcb_run.json', 'w') do |f|
  f.write(top_rcb.to_json)
end

# ====================================================================================
# 3. Solution For Problem Three
# ====================================================================================

# pick umpire name from umpire.csv if it's not from India and find the total occurance in IPL
# and store it with its country in @umpire_detail_hash with its occurances
umpire_details = obj.get_umpire_details(umpires_file, matches_file)

# sum the total occurance by country from umpire_detail hash and store in @coutry_umpire_hash with country name
country_umpire = obj.country_umpire_details(umpire_details)

# Generate Json file by the help of hash
File.open('json/total_ump_from_country.json', 'w') do |f|
  f.write(country_umpire.to_json)
end

#====================================================================================
# 4. Solution For Problem Four
#====================================================================================

# find the list of seasons and store it in @season_hash by only one occurance of each
season = obj.sort_get_season(matches_file)

# count the all occurance of team by each seasons and store it in @occr_team file with team name
team_details = obj.team_occr(season, matches_file)

# Generate Json file by the help of hash
File.open('json/team_details.json', 'w') do |f|
  f.write(team_details.to_json)
end
