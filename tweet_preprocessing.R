# load required packages
library(tidyverse)
library(lubridate)

# set timezone to UTC
Sys.setenv(TZ="UTC")
Sys.timezone()

#############
# processing flagged tweet data


flagged1 <- read_csv("data/CSVs/Raw/flagged.csv", cols(.default = col_character()), col_names = TRUE)
# created_at in this data appears to be in UTC
flagged1 <- flagged1 %>%
  mutate(created_at = mdy_hm(created_at), # time stamp to datetime
         # removing any stray white space
         text = str_squish(text),
         screen_name = str_squish(screen_name)) %>%
  # remove dupes
  distinct()

flagged2 <- read_csv("data/CSVs/Raw/hobbs_flagler_unique.csv", cols(.default = col_character()), col_names = TRUE) %>%
  # removing the alerts with no screen name
  filter(!is.na(screen_name))
# time_posted in this data appears to be in local time

# create a tibble with timezones for hobbs and flagler, join to flagged2 and force to UTC
timezones <- tibble(district = c("hobbs_nm","flagler_fl"), timezone = c("America/Denver","America/New_York"))

flagged2 <- inner_join(flagged2,timezones) %>%
  mutate(created_at = mdy_hm(time_posted),
         created_at = case_when(grepl("PM",time_posted) ~ created_at + 0.5, # adding half a day for PM
                                TRUE ~ created_at),
         created_at = force_tzs(created_at,timezone,tzone_out = "UTC"),
         content = str_squish(content),
         screen_name = str_squish(screen_name)) %>%
  # remove any dupes
  distinct()

# find the dupes with an inner join on district and created_at
duplicated_tweets <- inner_join(flagged1,flagged2, by = c("district" = "district","created_at"="created_at")) %>%
  select(district, created_at, content, text) # I looked at these to check text matched

duplicated_tweets <- duplicated_tweets %>%
  select(district,created_at) %>%
  unique()

# remove these dupes from flagler2 with an anti join, then rename content to text
flagged2 <- anti_join(flagged2,duplicated_tweets, by = c("district" = "district","created_at" = "created_at")) %>%
  rename(text = content)

# combine into a single flagged tweets tibble, select required variables and run distinct() in case any stray dupes
flagged <- bind_rows(flagged1,flagged2) %>%
  select(district,screen_name,text,created_at) %>%
  arrange(district, screen_name,created_at) %>%
  # I found I had to dedupe on a text version of created_at to move this work properly
  distinct(district,screen_name,as.character(created_at),.keep_all = TRUE) %>%
  select(1:4)

# write to CSV
write_csv(flagged, "data/CSVs/Created/flagged.csv")


  

