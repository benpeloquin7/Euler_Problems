## Eueler Problem 19
## https://projecteuler.net/problem=19

#####
##### set-up
#####
library(dplyr)
library(tidyr)
setwd("/Users/benpeloquin/Desktop/Euler_Problems/")

#####
##### helpers
#####
isLeapYear <- function(year) {
  if (year %% 100 == 0) {
    year %% 400 == 0  
  } else year %% 4 == 0
}

rollDays <- function(n) {
  dayLetters <- c("m", "t", "w", "r", "f", "s" ,"n")
  if (n < 7) r <- c()
  else {
    r <- rep(dayLetters, floor(n / 7))
    leftOver <- n %% 7
  }
  
  if (length(r) < n) {
    r <- c(r, dayLetters[seq(1, leftOver)])
  }
  r
}

numDaysInMonth <- function(monthNum, isLeapYear) {
  monthsData <- data.frame(name = month.name,
                           monthsNL = c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
                           monthsL  = c(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31))
  ifelse (isLeapYear,
          monthsData[monthNum, "monthsL"],
          monthsData[monthNum, "monthsNL"])
}

getRepYears <- function(year, nReps) rep(year, nReps)

#####
##### data
#####
daysNonLeap <- 30 * 4 + 31 * 7 + 28
daysLeap <- daysNonLeap + 1
months <- 1:12
years <- seq(1900, 2000)
leapYears <- sapply(seq(1900, 2000), isLeapYear)
yearD <- data.frame(year = years) %>%
  mutate(isLeapYear = leapYears,
         totalDays = ifelse(isLeapYear, daysLeap, daysNonLeap))
totalDays <- sum(yearD$totalDays)

## primary df store
daysVec <- rollDays(n = totalDays)
yearsVec <- unlist(mapply(getRepYears, yearD$year, yearD$totalDays))

## populate generic count, days, years
dStore <- data.frame(count = seq(1, totalDays), days = daysVec, years = yearsVec)

## populate months vector
monthsVec <- (unlist(lapply(years, FUN = function(y) {
  if (isLeapYear(y)) {
    unlist(sapply(seq(1,12), FUN = function(m) {
      nDays <- numDaysInMonth(m, TRUE)
      rep(m, nDays)
    }))
  } else {
    unlist(sapply(seq(1,12), FUN = function(m) {
      nDays <- numDaysInMonth(m, FALSE)
      rep(m, nDays)
    }))
  }
})))
dStore$month <- monthsVec

## populate first of month checks
firstOfMonths <- with(dStore,
                      mapply(c(1, month[seq(1, length(month)-1)]), month[seq(1, length(month))],
                             FUN = function(x, y) {
                               x != y
                               }))
dStore$firstOfMonth <- firstOfMonths

#####
##### analysis
#####
dStore %>% 
  filter(days == "n" & firstOfMonth & years != 1900) %>%
  nrow()
