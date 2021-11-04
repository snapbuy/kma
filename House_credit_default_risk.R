library(tidyverse)
library(skimr)
library(GGally)
library(plotly)
library(viridis)
library(caret)
library(DT)
library(data.table)
library(lightgbm)
library(xgboost)
library(kableExtra)
library(magrittr)
set.seed(0)

cat("Loading data...\n")
DATA_PATH = "./data/home-credit-default-risk/"
na_strings = c("NA", "NaN", "?", "")

# code
train = fread(paste0(DATA_PATH, "application_train.csv"), 
              stringsAsFactors = FALSE, 
              data.table = FALSE, na.strings = na_strings)
??fread
head(train)

###
train %>% 
  group_by(TARGET) %>% 
  summarise(Count = n())

###
train %>% 
  group_by(TARGET) %>% 
  summarise(Count = n() / nrow(train) * 100) %>% 
  arrange(desc(Count)) %>% 
  ungroup() %>% 
  mutate(TARGET = reorder(TARGET, Count)) %>% 
  ggplot(aes(x = TARGET, y = Count)) + 
  geom_bar(stat = "identity", fill = "#5D5BDE") + 
  geom_text(aes(x = TARGET, y = 1, label = paste0(round(Count, 2), " %")), 
            hjust = 0, vjust = .5, size = 3.5, colour = "white", fontface = "bold") + 
  coord_flip() + 
  theme_minimal()

###
train %>% 
  filter(!is.na(TARGET), CODE_GENDER != "XNA", CNT_FAM_MEMBERS <= 4) %>% # nrow() ~ 303498
  group_by(age = -round(DAYS_BIRTH/365, 0), 
           gender = ifelse(CODE_GENDER == "M", "Male", "Female"), 
           status = ifelse(NAME_FAMILY_STATUS == "Civil marriage", "Married", 
                           ifelse(NAME_FAMILY_STATUS == "Single / not married", "Single", as.character(NAME_FAMILY_STATUS)))) %>% # select(NAME_FAMILY_STATUS)
  summarise(count = n(), 
            AVG_CREDIT = mean(AMT_CREDIT), 
            AVG_TARGET = mean(TARGET)) %>% 
  mutate(AVG_TARGET = pmin(pmax(AVG_TARGET, 0.00), 0.20) * 100) %>% 
  ggplot(aes(x = age, y = count, fill = AVG_TARGET)) + 
  geom_histogram(stat = "identity", width = 1) + 
  facet_grid(gender ~ status) + 
  scale_fill_gradient("Avg. Default Rate %", low = "white", high = "blue") + 
  labs(title = "Default Rate of Applicants (N = 303,498)", 
       subtitle = "Age, Gender, And Marriage Status", 
       caption = "Created by McBert") +   
  theme_minimal()

###

summary(train$AMT_CREDIT)
ggplot(train, aes(x = AMT_CREDIT)) + 
  geom_histogram(bins = 30, fill = "#5D5BDE") + 
  facet_grid( ~ TARGET) + 
  theme_minimal()

###
up_threshold = quantile(train$AMT_CREDIT, 0.975)
print(up_threshold)

# 시각화
train %>% 
  filter(AMT_CREDIT <= up_threshold) %>% 
  ggplot(aes(x = AMT_CREDIT)) + 
  geom_histogram(bins = 30, fill = "#5D5BDE") + 
  facet_grid(CODE_GENDER ~ TARGET) + 
  theme_minimal()


table(train$CNT_FAM_MEMBERS)
table(train$NAME_FAMILY_STATUS)
nrow(train)

train %>% 
  filter(!is.na(TARGET), CODE_GENDER != "XNA", CNT_FAM_MEMBERS <= 4) %>% # nrow() ~ 303498
  group_by(age = -round(DAYS_BIRTH/365, 0), 
           gender = ifelse(CODE_GENDER == "M", "Male", "Female"), 
           status = ifelse(NAME_FAMILY_STATUS == "Civil marriage", "Married", 
                           ifelse(NAME_FAMILY_STATUS == "Single / not married", "Single", as.character(NAME_FAMILY_STATUS)))) %>% # select(NAME_FAMILY_STATUS)
  summarise(count = n(), 
            AVG_CREDIT = mean(AMT_CREDIT), 
            AVG_TARGET = mean(TARGET)) %>% 
  mutate(AVG_TARGET = pmin(pmax(AVG_TARGET, 0.00), 0.20) * 100) %>% 
  ggplot(aes(x = age, y = count, fill = AVG_TARGET)) + 
  geom_histogram(stat = "identity", width = 1) + 
  facet_grid(gender ~ status) + 
  scale_fill_gradient("Avg. Default Rate %", low = "white", high = "blue") + 
  labs(title = "Default Rate of Applicants (N = 303,498)", 
       subtitle = "Age, Gender, And Marriage Status", 
       caption = "Created by McBert") +   
  theme_minimal()

summarise(train)


library(scales)
train %>% 
  filter(!is.na(TARGET), CODE_GENDER != "XNA", CNT_FAM_MEMBERS <= 4) %>% 
  mutate(CODE_GENDER = ifelse(CODE_GENDER == "M", "Male", "Female"), 
         DEPT_INCOMES_RATIO = AMT_ANNUITY/AMT_INCOME_TOTAL) %>% 
  select(CODE_GENDER, DEPT_INCOMES_RATIO, TARGET) %>%
  ggplot(aes(x = DEPT_INCOMES_RATIO, y = TARGET)) + 
  geom_smooth(se = FALSE) + 
  scale_x_continuous(name = "Debt / Incomes Ratio (%)", 
                     limits = c(0, 0.5), 
                     labels = percent_format(accuracy = 0.1)) + 
  # coord_cartesian(ylim=c(0.00, 0.15)) + 
  scale_y_continuous(name = "Avg. Default Rate (%)", 
                     breaks = seq(0, 1, 0.01), 
                     labels = percent_format(accuracy = 0.1)) + 
  facet_grid(~ CODE_GENDER) + 
  labs(title = "Default Rate by Debt/Incomes Ratio (N = 303,498)", 
       subtitle = "The Comparison between Female and Male", 
       caption = "Created by McBert") +
  theme_minimal()



test = fread(paste0(DATA_PATH, "application_test.csv"), 
             stringsAsFactors = FALSE, 
             data.table = FALSE, na.strings = na_strings)

head(test)

bureau = fread(paste0(DATA_PATH, "bureau.csv"), 
               stringsAsFactors = FALSE, 
               data.table = FALSE, na.strings = na_strings)

head(bureau)
dim(bureau)


bur_balance = fread(paste0(DATA_PATH, "bureau_balance.csv"), 
                    stringsAsFactors = FALSE, 
                    data.table = FALSE, na.strings = na_strings)

head(bur_balance)
dim(bur_balance)


table(bur_balance$SK_ID_BUREAU) %>% head(10)

table(train$SK_ID_CURR) %>% head(10)



stat_fn = list(mean = mean, sd = sd)

sum_bur_balance = bur_balance %>% 
  mutate_if(is.character, funs(factor(.) %>% as.integer)) %>% 
  group_by(SK_ID_BUREAU) %>% 
  mutate(SK_ID_BUREAU = as.character(SK_ID_BUREAU)) %>% 
  summarise_all(stat_fn, na.rm = TRUE)

sum_bur_balance %>% head()
