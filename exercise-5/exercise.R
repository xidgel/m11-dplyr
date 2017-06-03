# Exercise 5: DPLYR Grouped Operations

# Install the nycflights13 package and read it in. Require the dplyr package.
# install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# In which month was the average departure delay the greatest?
# Hint: you'll have to perform a grouping operation before summarizing your data
dep.delay.summary <- group_by(flights, month) %>% filter(!is.na(dep_delay)) %>% summarize(mean=mean(dep_delay))

# If you create a data.frame with the columns "month", and "delay" above, you should be able to create 
# a scatterplot by passing it to the 'plot' function
plot(dep.delay.summary)

# In which airport were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation before summarizing your data
arr.delay.summary <- group_by(flights, dest) %>% filter(!is.na(arr_delay)) %>% summarize(mean=mean(arr_delay))
max.arr.delay <- max(arr.delay.summary$mean)
worst.airport <- filter(arr.delay.summary, mean==max.arr.delay)$dest
paste("The worst airport for arrival delays was", worst.airport)

### Bonus ###
# Which city was flown to with the highest average speed?
air.speed <- mutate(flights, air_speed=distance/air_time*60) %>% # add air speed column
             group_by(dest) %>%                                  # do stats by dest city
             filter(!is.na(air_speed)) %>%                       # filter out NA
             summarize(mean=mean(air_speed))
max.air.speed <- max(air.speed$mean)
highest.inbound.speed <- filter(air.speed, mean==max.air.speed)$dest
paste("The city with the highest inbound speed was", highest.inbound.speed)