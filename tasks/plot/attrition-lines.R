library('ggplot2')
library('dplyr')
library('plyr')
library('directlabels')

extract.total <- function(df) {
  return(df$total)
}

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

compile.attrition <- function(df) {
  school <- getmode(df$school)
  df %>% group_by(year, name) %>%
    summarise(total = count(year)) %>%
    extract.total() %>%
    mutate(x = factor(x, levels=c("FR", "SO", "JR", "SR"))) %>%
    mutate(school = school) %>%
    mutate(proportion = freq/max(freq)) %>%
    filter(x != 'NA')
}

teams <- c(
  "CMU",
  "Emory",
  "Chicago",
  "WashU",
  "NYU",
  "Case",
  "Rochester",
  "Brandeis",
  "Hopkins",
  "MIT",
  "Kenyon",
  "Denison",
  "Florida",
  "Stanford",
  "Harvard",
  "Michigan",
  "Georgia",
  "GeorgiaTech"
)

teams.dat <- tibble()

for(team in teams) {
  print(team)
  attrition.dat <- ingest(team) %>% compile.attrition()
  teams.dat <- rbind(teams.dat, attrition.dat)
}

as.percentage <- function(num) {
  paste(round(num, digits = 2) * 100, "%", sep="")
}

teams.dat %>%
  filter(school == 'CMU') %>%
  ggplot() +
  aes(x = x, y = proportion) +
  geom_col() +
  geom_text(aes(label = as.percentage(proportion), y = proportion + .05)) + 
  labs(
    title = "All Time Class Count",
    subtitle = "Members of the team who started the season as a FR/SO/JR/SR",
    y = "% of people",
    x = "Class"
  ) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )

ggsave('plots/all-time-class-count.png', width = 8, height = 4)

line.plot <- teams.dat %>%
  mutate(class = revalue(x, c("FR" = 1, "SO" = 2, "JR" = 3, "SR" = 4))) %>%
  ggplot() +
    aes(x = class, y = proportion, group = school, colour = school) +
    geom_line() +
    scale_x_discrete(labels=c(
      "1" = "FR",
      "2" = "SO",
      "3" = "JR",
      "4" = "SR"
    )) +
  labs(
    title = "Attrition by School",
    subtitle="Every school is scaled against themselves",
    colour = "School",
    y = "Proportion of Freshman class remaining"
  )

direct.label.ggplot(line.plot, 'last.qp')

ggsave('plots/attrition-by-team.png', width = 7, height = 10)
