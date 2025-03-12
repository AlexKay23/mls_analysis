

source("mls_xg.R")


ggplot(mls_xgs_long %>% filter(team_helper %in% c("LA Galaxy","Inter Miami CF","FC Cincinnati","Columbus Crew")), aes(x=date_time_utc,y=goals,color=team_helper))+
  geom_line(aes(group = team_helper,linewidth = 1))





