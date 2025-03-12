library(rvest)


logo_links = "https://www.mlssoccer.com/clubs/"
page = read_html(logo_links)

teams= page %>% html_nodes(".mls-o-clubs-hub-clubs-list__club-name span") %>% html_text()
logo= page %>% html_nodes("#main-content .img-responsive") %>% html_attr("src")

team_df <- as_tibble(teams) %>% filter(!value == "") %>% rename(team_name = value)
logo_df <- as_tibble(logo) %>% rename(logo_url = value)

team_logos_df <- bind_cols(team_df,logo_df)


write_csv(team_logos_df,file = "Data/logosData.csv")