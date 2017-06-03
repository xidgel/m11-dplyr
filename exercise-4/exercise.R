# Exercise 4: DPLYR and flights data

# Install the nycflights13 package and read it in.  Require the dplyr package
#install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data.frame flights should now be accessible to you.  View it, 
# and get some basic information about the number of rows/columns
# View(flights)
dim(flights)

# Add a column that is the amount of time gained in the air (`arr_delay` - `dep_delay`)
f1 <- mutate(flights, time_gained = arr_delay-dep_delay)

# Sort your data.frame desceding by the column you just created
f1 <- arrange(f1, -time_gained)

# Try doing the last 2 steps in a single operation using the pipe operator
f2 <- mutate(flights, time_gained = arr_delay-dep_delay) %>% arrange(-time_gained)

# Make a histogram of the amount of gain using the `hist` command
hist(f2$time_gained)

# On average, did flights gain or lose time?
tg <- select(f2, time_gained) %>% filter(!is.na(time_gained)) %>% summarize(mean=mean(time_gained))
paste("The mean time gain was", tg$mean)

# Create a data.frame that is of flights headed to seatac ('SEA'), 
sea <- filter(f2, dest=="SEA")

# On average, did flights to seatac gain or loose time?
sea.tg <- select(sea, time_gained) %>% filter(!is.na(time_gained)) %>% summarize(mean=mean(time_gained))
if(sea.tg$mean>0){
  g <- "gained"
}else{
  g <- "lost"
}
paste("On average, flights from SEA-TAC", g, "time during the flight.")

### Bonus ###
# Write a function that allows you to specify an origin, a destination, and a column of interest
# that returns a data.frame of flights from the origin to the destination and only the column of interest
## Hint: see chapter 11 section on standard evaluation
FlightData <- function(origin, destination, column){
  r <- filter(flights, origin==origin, dest==destination) %>% select_(column)
  return(r)
}

# Retireve the air_time column for flights from JFK to SEA
at <- FlightData("JFK", "SEA", "air_time")

# What was the average air time of those flights (in hours)?  
smry.air.time.hours <- filter(at, !is.na(air_time)) %>% summarize(
  mean=mean(air_time)/60,
  min=min(air_time)/60,
  max=max(air_time)/60)
paste("The average air time was", smry.air.time.hours$mean, "hours.")

# What was the min/max average air time for the JFK to SEA flights?
paste("The min and max air time wer", smry.air.time.hours$min, "and", smry.air.time.hours$max, "hours.")
