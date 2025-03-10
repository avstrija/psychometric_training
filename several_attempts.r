df <- read.table("book_dataset_2a.tsv", header= TRUE, quote= "", sep= "\t")
library(dplyr)

df <- df %>%
    group_by(student_id, task_id) %>%
    arrange(timestamp) %>%
    mutate(attempt = row_number())

head(as.data.frame(df))

p_i <- df %>%
    filter(attempt == 1) %>%
    group_by(task_id) %>%
    summarise(
        n_Correct = sum(is_correct == 1),
        n_Incorrect = sum(is_correct == 0),
        p_i = round(n_Correct / (n_Correct + n_Incorrect), 2),
        .groups = "drop"
    ) %>%
    select(task_id, p_i)

head(as.data.frame(p_i))

p_i[p_i$task_id %in% c("43f464b92996aa28", "5f596b6d2bf8eb9b", "67e3272b9bf1e589", "92fecefdabe81f5c"),]

p_ia <- df %>%
    filter(attempt <= 3) %>%
    group_by(task_id, attempt) %>%
    summarise(
        n_Correct = sum(is_correct == 1),
        n_Incorrect = sum(is_correct == 0),
        .groups = "drop"
    ) %>%
    group_by(task_id) %>%
    mutate(
        cum_n_Correct = cumsum(n_Correct)
    ) %>%
    ungroup() %>%
    mutate(
        p_ia = round(cum_n_Correct / (cum_n_Correct + n_Incorrect), 2)
    ) %>%
    select(task_id, attempt, p_ia)

head(as.data.frame(p_ia))

install.packages("tidyr",repos = "http://cran.us.r-project.org")
library(tidyr)