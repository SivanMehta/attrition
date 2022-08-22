library('ggplot2')
library('dplyr')
library('plyr')

dat <- tibble()

# plot class size per year
start <- 2011
end <- 2021

for (year in start:end) {
  filename <- paste('data/', year, '.csv', sep='')
  yearly.data <- read.csv(filename, sep='|')
  yearly.data$school.year = year
  dat <- rbind(dat, yearly.data)
}

# data cleaning
dat <- dat %>%
  filter(year != '–') %>%
  mutate(graduating.class = NA) %>%
  mutate(graduating.class = revalue(year, c("FR" = 4, "SO" = 3, "JR" = 2, "SR" = 1))) %>%
  mutate(graduating.class = as.numeric(graduating.class) + school.year) %>%
  mutate(year = factor(year, levels=c("FR", "SO", "JR", "SR")))
  
