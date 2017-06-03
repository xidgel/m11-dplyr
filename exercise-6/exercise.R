# Exercise 6: DPLYR join introduction

# Install the nycflights13 package and read it in. Require the dplyr package.
# install.packages("nycflights13")
library(nycflights13)
library(dplyr)


# Create a dataframe of the average arrival delay for each destination, then use left_join
# to join on the "airports" dataframe, which has the airport info
arr.delay.dest <- select(flights, dest, arr_delay) %>% # select dest and arr_delay columns
                  filter(!is.na(arr_delay)) %>%        # filter out NA
                  group_by(dest)  %>%                  # compute stats by dest city
                  summarize(mean=mean(arr_delay))      # compute avg delays
arr.delay.dest.join <- left_join(arr.delay.dest, airports, by=c("dest"="faa"))

# Create a dataframe of the average arrival delay for each airline, then use left_join
# to join on the "airlines" dataframe, which has the airline info
arr.delay.carrier <- select(flights, carrier, arr_delay) %>% # select carrier and arr_delay columns
                     filter(!is.na(arr_delay)) %>%           # filter out NA
                     group_by(carrier) %>%                   # compute stats by carrier
                     summarize(mean=mean(arr_delay))         # compute avg delays
arr.delay.carrier.join <- left_join(arr.delay.carrier, airlines, by=c("carrier"="carrier"))

### Bonus ###
# Calculate the average delay by city AND airline, then merge on the city and airline information


# If you're running into sorting issues:
# http://stackoverflow.com/questions/26555297/dplyr-arrange-a-grouped-df-by-group-variable-not-working