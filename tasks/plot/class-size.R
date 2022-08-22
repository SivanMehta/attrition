library('ggplot2')
library('dplyr')
library('plyr')

background.color = '#EBEBEB'

dat %>%
  ggplot() +
  aes(x = school.year, fill = year) +
  geom_bar(color = background.color) +
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
    title = 'Class Size by Year',
    subtitle = "Coloring by class at the start of the year"
  )

ggsave('plots/relative-class-size-by-year.png', width = 8, height = 4)

dat %>%
  ggplot() +
  aes(x = school.year, fill = as.factor(graduating.class)) + 
  geom_bar(color = background.color) +
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
    title = 'Year-over-Year Class Size',
    subtitle = "Coloring by graduating class. Freshman appear at the bottom of the graph",
    fill='Graduating Class'
  )

ggsave('plots/class-attrition-by-year.png', width = 8, height = 4)

dat %>%
  filter(school.year > 2013) %>%
  ggplot() +
  aes(x = school.year, fill = year) + 
  geom_bar(color = background.color, position='fill') +
  theme(
    axis.text.x = element_text(angle=45)
  ) +
  scale_x_continuous(
    name = 'Start of Year',
    breaks = c(start:end)
  ) +
  scale_y_continuous(
    name='Proportion of students of Students',
  ) +
  labs(
    title = 'Class Proportion by Year',
    subtitle = "Coloring by class at the start of the year"
  )

ggsave('plots/relative-class-proportion-by-year.png', width = 8, height = 4)

dat %>%
  ggplot() +
  aes(x = school.year, fill = as.factor(graduating.class)) + 
  geom_bar(color = background.color, position = 'fill') +
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
    title = 'Year-over-Year Class Size',
    subtitle = "Coloring by graduating class. Freshman appear at the bottom of the graph",
    fill='Graduating Class'
  )

ggsave('plots/class-proportion-by-year.png', width = 8, height = 4)
