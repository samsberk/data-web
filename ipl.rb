# frozen_string_literal: true

require 'csv'

# class for IPL data analysis
class Ipl # rubocop:disable Metrics/ClassLength
  # rubocop:disable Metrics/MethodLength
  def hello
    'Hello! World.'
  end

  # Find all team names and store only one occurance of each team in @team_hash from matches_file
  def unique_team(matches_file)
    team = {}
    index = 0
    matches_file.length.times do |i|
      flag = 0
      team.length.times do |j|
        flag += 1 if team[j] == matches_file[i][4]
      end
      if flag.zero?
        team[index] = matches_file[i][4]
        index += 1
      end
    end
    team
  end

  # sum the tot_run and store in @teamrun_hash with team name
  def count_team_run(team, deliveries_file)
    teamrun = {}
    team.length.times do |i|
      totrun = 0
      deliveries_file.length.times do |j|
        totrun += deliveries_file[j][17].to_i if team[i] == deliveries_file[j][2]
      end
      teamrun[team[i]] = totrun
    end
    teamrun
  end

  # find all RCB players name and make one occurance and store in @rcb_players_hash
  def players_name(deliveries_file)
    rcb_players = {}
    index = 0
    deliveries_file.length.times do |i|
      next unless deliveries_file[i][2] == 'Royal Challengers Bangalore'

      flag = 0
      rcb_players.length.times do |j|
        flag += 1 if rcb_players[j] == deliveries_file[i][6]
      end
      if flag.zero?
        rcb_players[index] = deliveries_file[i][6]
        index += 1
      end
    end
    rcb_players
  end

  # sum the total score of each player of RCB in IPL and store it in @rcb_run_hash with their name
  def players_run(rcb_players, d_file)
    rcb_run = {}
    rcb_players.length.times do |i|
      score = 0
      d_file.length.times do |j|
        score += d_file[j][17].to_i if rcb_players[i] == d_file[j][6] && d_file[j][2] == 'Royal Challengers Bangalore'
      end
      rcb_run[rcb_players[i]] = score
    end
    rcb_run
  end

  # pick umpire name from umpire.csv if it's not from India and find the total occurance in IPL
  # and store it with its country in @umpire_detail_hash with its occurances
  def get_umpire_details(umpires_file, matches_file) # rubocop:disable Metrics/AbcSize
    umpire_details = Hash.new { |hash, key| hash[key] = [] }
    umpires_file.length.times do |i|
      next unless umpires_file[i][1] != 'India'

      ct = 0
      matches_file.length.times do |j|
        ct += 1 if (umpires_file[i][0] == matches_file[j][15]) || (umpires_file[i][0] == matches_file[j][16])
      end
      umpire_details[umpires_file[i][0]][0] = umpires_file[i][1]
      umpire_details[umpires_file[i][0]][1] = ct
    end
    umpire_details
  end

  # sum the total occurance by country from umpire_detail hash and store in @coutry_umpire_hash with country name
  def country_umpire_details(umpire_details)
    country_umpire = {}
    umpire_details.each do |k1, _v1|
      sum = 0
      umpire_details.each do |k2, _v2|
        sum += 1 if umpire_details[k1][0] == umpire_details[k2][0]
      end
      country_umpire[umpire_details[k1][0]] = sum
    end
    country_umpire
  end

  # find the list of seasons and store it in @season_hash by only one occurance of each
  def sort_get_season(matches_file) # rubocop:disable Metrics/AbcSize
    season = {}
    arr_season = []
    index = 0
    matches_file.length.times do |i|
      flag = 0
      arr_season.length.times do |j|
        flag += 1 if arr_season[j].to_s == matches_file[i][1]
      end
      if flag.zero?
        arr_season[index] = matches_file[i][1].to_i
        index += 1
      end
    end
    arr_season = arr_season.sort
    arr_season.each_with_index do |vlu, idx|
      season[idx] = vlu.to_s
    end
    season
  end

  # count the all occurance of team by each seasons and store it in @team_details file with team name
  def team_occr(season, matches_file) # rubocop:disable Metrics/AbcSize
    team_details = Hash.new { |hash, key| hash[key] = [] }
    team = unique_team(matches_file)
    team.each do |_ind, tname|
      index = 0
      season.each do |_key, year|
        ct = 0
        matches_file.length.times do |i|
          ct += 1 if (matches_file[i][1] == year) && ((matches_file[i][4] == tname) || (matches_file[i][5] == tname))
        end
        team_details[tname][index] = ct
        index += 1
      end
    end
    team_details
  end

  # rubocop:enable Metrics/MethodLength
end
