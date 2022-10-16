
library(reshape)
library(ggplot2)
library(dplyr)
library(readr)
df <- list.files(path = "C:/Development/R Program/Data Set Saved Here/COVID-19-master/csse_covid_19_data/csse_covid_19_daily_reports_us", full.names = TRUE)%>%
  lapply(read_csv) %>%
  bind_rows

df$Mortality_Rate[which(df$Mortality_Rate == 0)] <- NA


table(df$Mortality_Rate)

str(df$Date)

df = filter(df, Date <= "2022-04-12")


df <- select(df, -c(Last_Update, Lat, Long_, Country_Region))
temp <- select(df, c(Date, Confirmed, Province_State))

colSums(is.na(df))

table(df$FIPS)

ggplot(data = df, mapping = aes(x = Date, y = Confirmed, color = Province_State)) +
  geom_point()



ggplot(data = df, mapping = aes(x = Date, y = Confirmed)) +
  geom_point() + facet_wrap(~(Province_State), scales = "free", nrow = 5) +
  theme(axis.text.x = element_blank(), axis.text.y = element_blank())

#ggplot(data = df, mapping = aes(x = Date, y = Deaths, fill = Deaths)) +
#  geom_tile() + scale_fill_gradient(low = "white", high = "red") + 
#  facet_wrap(~(Province_State), scales = "free", nrow = 5) +
#  theme(axis.text.x = element_blank(), axis.text.y = element_blank())

