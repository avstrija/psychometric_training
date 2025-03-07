df <- read.table("book_dataset_2a.tsv", header= TRUE, quote= "", sep= "\t")
head(as.data.frame(df))
library(dplyr)

df <- df %>%
    group_by(student_id, task_id) %>%
    arrange(timestamp) %>%
    mutate(attempt = row_number())

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