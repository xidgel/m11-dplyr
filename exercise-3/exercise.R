# Exercise 3: Data Frame Practice with `dplyr`.
# Use a different appraoch to accomplish the same tasks as exercise-1


# Install devtools package: allows installations from GitHub
#install.packages('devtools')

# Install "fueleconomy" package from GitHub
#devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package
# Install (if you haven't already) and load the `dplyr`package
library(dplyr)

# Which Accura model has the best hwy MPG in 2015? (without method chaining)
vehicles.df <- data.frame(vehicles, stringsAsFactors=FALSE)
Acura <- filter(vehicles.df, make=="Acura")
Acura.2015 <- filter(Acura, year==2015)
best.Acura.2015 <- filter(Acura.2015, hwy==max(hwy))
best.Acura.2015.model <- select(best.Acura.2015, model)
best.Acura.2015.model

# Which Accura model has the best hwy MPG in 2015? (nesting functions)
best.Acura.2015.model <- 
  select(
    filter(
      filter(
        filter(
          vehicles.df, make=="Acura"),   # filter to Acura vehicles
        year==2015),  # filter to 2015
      hwy==max(hwy)),  # filter to max hwy
    model)  # select model
best.Acura.2015.model


# Which Accura model has the best hwy MPG in 2015? (pipe operator)
best.Acura.2015.model <- filter(vehicles, make=="Acura") %>% 
                         filter(year==2015) %>%
                         filter(hwy==max(hwy)) %>%
                         select(model)
best.Acura.2015.model
### Bonus ###

# Write 3 functions, one for each approach.  Then, 
# Test how long it takes to perform each one 1000 times
