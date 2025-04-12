
source("mls_xg.R")


salaries <- asa_client$get_player_salaries()
players <- asa_client$get_players()



player_salary <- left_join(salaries,players)


ggplot(player_salary, aes(x=season_name,y=base_salary))+
  geom_col()+
  labs(title = "Annual Salries By Position",
       x = "Season",
       y= "Base Salary")+
  theme_bw()+
  facet_wrap(~position)

ggplot(player_salary, aes(x=position,y=base_salary))+
  geom_boxplot(outliers = FALSE)+        # exlcuding outliars because most of them are in "F" and made chart difficult to read
  labs(title = "Salary Comparisons by Position",
       x= "Position",
       y= "Base Salary")+
  theme_bw()



# Percent increase in wages ####
## what is the average annual increase in wages for each position?