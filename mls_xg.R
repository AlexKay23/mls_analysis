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



mls_xgs_long <- mls_xgs %>% 
  pivot_longer(cols = c(18,21),
               names_to = "team_status",
               values_to = "team_helper") %>% 
  mutate(goals = case_when(team_status == "away_team_name" ~ away_goals,
                           team_status == "home_team_name" ~ home_goals)) %>% 
  mutate(team_xG = case_when(team_status == "away_team_name" ~ away_team_xgoals,
                             team_status == "home_team_name" ~ home_team_xgoals)) %>% 
  mutate(team_xPoints = case_when(team_status == "away_team_name" ~ away_xpoints,
                             team_status == "home_team_name" ~ home_xpoints)) %>% 
  group_by(game_id) %>% 
  mutate(win_loss = case_when(
    goals == max(goals) & goals != min(goals) ~ "Win",
    goals == min(goals) & goals != max(goals) ~ "Loss",
    goals == max(goals) & goals == min(goals) ~ "Draw"
  )) %>%
  ungroup() %>% 
  mutate(points= case_when(win_loss == "Win" ~ 3,
                           win_loss == "Loss" ~ 0,
                           TRUE ~ 1)) %>% 
  ungroup()




