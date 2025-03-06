df <- read.table("book_dataset_1.tsv", header=TRUE, quote="", sep="\t")
head(as.data.frame(df))
library(dplyr)

p_i <- df %>%
    group_by(task_id) %>%
    summarise(
        n_Correct = sum(is_correct == 1),
        n_Incorrect = sum(is_correct == 0),
        p_i = round(n_Correct / (n_Correct + n_Incorrect), 2),
        .groups = "drop"
    ) %>%
    select(task_id, p_i)

head(as.data.frame(p_i))