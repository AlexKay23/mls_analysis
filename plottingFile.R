

source("mls_xg.R")
library(forcats)


ggplot(mls_xgs_long %>% filter(team_helper %in% c("LA Galaxy","Inter Miami CF","FC Cincinnati","Columbus Crew")), aes(x=date_time_utc,y=goals,color=team_helper))+
  geom_line(aes(group = team_helper,linewidth = 1))




#sum of goals by season

mls_xgs_long %>%
  group_by(season, team_helper) %>%
  summarise(total_goals = sum(goals, na.rm = TRUE), .groups = "drop") %>%
  # Order team_helper alphabetically (A-Z)
  mutate(team_helper = factor(team_helper, levels = rev(sort(unique(team_helper))))) %>%
  ggplot(aes(x = team_helper, y = total_goals)) +
  geom_col() +
  coord_flip() + # Flip the coordinates
  facet_wrap(~season, scales = "free")+
  theme_bw()