## Eueler Problem 13
## https://projecteuler.net/problem=14

setwd("/Users/benpeloquin/Desktop/Euler_Problems/P14")

## recursive formulation too inefficient
recurse <- function(left, right, total) {
  if (left < 0 | right < 0) return(0)
  else if (left == 0 & right == 0) return(1)
  else {
    return(
      total +
        recurse(left - 1, right, total) +
        recurse(left, right - 1, total)
      )
  }
}
# recurse(20, 20, 0)

## closed form computation [[Centroal Binomial Coef]]
factorial <- function(n) {
  if (n == 0) return(1)
  return(n * factorial(n-1))
}
factorial(2*20) / factorial(20)^2
