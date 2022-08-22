library('ggplot2')
library('dplyr')

dat <- tibble()

# plot class size per year
start <- 2011
end <- 2021

for (year in start:end) {
  filename <- paste('data/', year, '.csv', sep='')
  yearly.data <- read.csv(filename, sep='|')
  dat <- rbind(dat, yearly.data)
}
