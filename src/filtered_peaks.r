library(ggplot2)
library(dplyr)

setwd("C:/source/bio/project") # should be altered

NAME <- 'vsm.hg38' # should be altered
OUT_DIR <- 'results/'

bed_df <- read.delim(paste0('data/', NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 5000)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.filtered.pdf'), path = OUT_DIR)

bed_df %>%
  select(-len) %>%
  write.table(file='data/vsm.hg38.filtered.bed', # should be altered
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)
