library('ggplot2')
library('dplyr')
library('plyr')

extract.total <- function(df) {
  return(df$total)
}

dat.CMU %>%
  group_by(year, name) %>%
  summarise(total = count(year)) %>%
  extract.total() %>%
  mutate(x = factor(x, levels=c("FR", "SO", "JR", "SR"))) %>%
  ggplot() +
    aes(x = x, y = freq) +
    geom_col() +
    geom_text(aes(label = freq, y = freq + 5)) + 
    labs(
      title = "All Time Class Count",
      subtitle = "Total people who started the season as a FR/SO/JR/SR",
      y = "Count",
      x = "Class"
    )

ggsave('plots/all-time-class-count.png', width = 8, height = 4)
             