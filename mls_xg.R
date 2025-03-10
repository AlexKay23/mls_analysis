library(itscalledsoccer)
library(tidyverse)


asa_client <- AmericanSoccerAnalysis$new()

mls_teams <- asa_client$get_teams(leagues = "mls")
mls_xgs <- asa_client$get_game_xgoals(leagues = "mls")


mls_goals_added <- asa_client$get_player_goals_added(leagues = "mls")



mls_xgs <- mls_xgs %>% 
  rename(team_id = home_team_id) %>% 
  left_join(.,mls_teams) %>% 
  rename(home_team_id = team_id,
         home_team_name = team_name,
         home_team_short = team_short_name,
         home_team_abbreviation = team_abbreviation) %>% 
  rename(team_id = away_team_id) %>% 
  left_join(.,mls_teams) %>% 
  rename(away_team_id = team_id,
         away_team_name = team_name,
         away_team_short = team_short_name,
         away_team_abbreviation = team_abbreviation)