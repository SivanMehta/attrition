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
  mutate(graduating.class = as.numeric(graduating.class) + school.year)

dat %>%
  ggplot() +
  aes(x = school.year, fill = year) +
  geom_bar() +
  theme(
    axis.text.x = element_text(angle=45)
  ) +
  scale_x_continuous(
    name = 'Start of Year',
    breaks = c(start:end)
  ) +
  scale_y_continuous(
    name='Number of Students'
  ) +
  labs(title = 'Class Size by Year')

ggsave('plots/relative-class-size-by-year.png', width = 8, height = 4)

dat %>%
  ggplot() +
  aes(x = school.year, fill = as.factor(graduating.class)) + 
  geom_bar() +
  theme(
    axis.text.x = element_text(angle=45)
  ) +
  scale_x_continuous(
    name = 'Start of Year',
    breaks = c(start:end)
  ) +
  scale_y_continuous(
    name='Number of Students'
  ) +
  labs(
    title = 'Year-over-Year Class Attrition',
    fill='Graduating Class'
  )

ggsave('plots/class-attrition-by-year.png', width = 8, height = 4)

dat %>%
  filter(school.year > 2013) %>%
  ggplot() +
  aes(x = school.year, fill = year) + 
  geom_bar(position='fill') +
  theme(
    axis.text.x = element_text(angle=45)
  ) +
  scale_x_continuous(
    name = 'Start of Year',
    breaks = c(start:end)
  ) +
  scale_y_continuous(
    name='Number of Students'
  ) +
  labs(title = 'Class Proportion by Year')

ggsave('plots/class-proportion-by-year.png', width = 8, height = 4)

