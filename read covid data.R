
library(usmap)
library(maps)
library(reshape)
library(ggplot2)
library(tidyverse)
library(cowplot)
df <- list.files(path = "C:/Development/R Program/Data Set Saved Here/COVID-19-master/csse_covid_19_data/csse_covid_19_daily_reports_us", full.names = TRUE)%>%
  lapply(read_csv) %>%
  bind_rows

df$Mortality_Rate[which(df$Mortality_Rate == 0)] <- NA


table(df$Mortality_Rate)

str(df$Date)

df <- filter(df, Date <= "2022-04-12")


df <- select(df, -c(Last_Update, Country_Region))

colSums(is.na(df))

table(df$FIPS)

ggplot(data = df, mapping = aes(x = Date, y = Confirmed, color = Province_State,)) +
  geom_point()

ggplot(data = df, mapping = aes(x = Date, y = Deaths, color = Province_State,)) +
  geom_point()

plot_grid(confirmed, deaths)


ggplot(data = df, mapping = aes(x = Date, y = Confirmed)) +
  geom_point() + facet_wrap(~(Province_State), scales = "free", nrow = 5) +
  theme(axis.text.x = element_blank(), axis.text.y = element_blank())

#ggplot(data = df, mapping = aes(x = Date, y = Deaths, fill = Deaths)) +
#  geom_tile() + scale_fill_gradient(low = "white", high = "red") + 
#  facet_wrap(~(Province_State), scales = "free", nrow = 5) +
#  theme(axis.text.x = element_blank(), axis.text.y = element_blank())

plot_usmap()

MainStates <- map_data("state")

df <- df %>% rename(region = Province_State)
df2 <- filter(df, Date == "2022-04-12")

df2$region <- tolower(df2$region)

work<-left_join(MainStates,df2,by = "region")


ggplot(work,mapping =  aes(x = long, y =lat, group= group, fill = Deaths)) +
  geom_polygon() +
  coord_quickmap()

  