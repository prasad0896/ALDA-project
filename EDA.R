# Exploratory Data Analysis
library(corrplot)
df <- read.csv("NBA Dataset/team_season.txt")
df <- df[-which(df$year <= 1978),]
df <- df[c(1:16,18:31,33:36)]

subset <- df
# subset <- df[c(1:17,19:20)]
subset$o_fgp <- subset$o_fgm/subset$o_fga
# # subset$o_3pp <- subset$o_3pm/subset$o_3pa
subset$o_ftp <- subset$o_ftm/subset$o_fta
subset$d_fgp <- subset$d_fgm/subset$d_fga
# # subset$o_3pp <- subset$o_3pm/subset$o_3pa
subset$d_ftp <- subset$d_ftm/subset$d_fta

subset <- subset[c(1:3,8:17,22:38)]
for(i in 4:22) {
  subset[i] <- subset[i]/(subset$won+subset$lost)
}
subset <- subset[-6]
subset <- subset[-15]

write.csv(subset, file="updatedStatsFrom79OAndD.csv", row.names = FALSE)
# M <- cor(subset[4:16])
# corrplot(M, method="square")

# ====================================
# 
# # Exploratory Data Analysis
# library(corrplot)
# df <- read.csv("NBA Dataset/team_season.txt")
# df <- df[-which(df$year <= 1998),]
# df <- df[c(1:18,34:36)]
# # 
# subset <- df
# # # subset <- df[c(1:17,19:20)]
# subset$o_fgp <- subset$o_fgm/subset$o_fga
# subset$o_3pp <- subset$o_3pm/subset$o_3pa
# subset$o_ftp <- subset$o_ftm/subset$o_fta
# # subset$d_fgp <- subset$d_fgm/subset$d_fga
# # # # subset$o_3pp <- subset$o_3pm/subset$o_3pa
# # subset$d_ftp <- subset$d_ftm/subset$d_fta
# # 
# subset <- subset[c(1:3,8:15,18:24)]
# for(i in 4:13) {
#   subset[i] <- subset[i]/(subset$won+subset$lost)
# }
# subset <- subset[-6]
# # subset <- subset[-15]
# # 
# write.csv(subset, file="updatedStatsFrom99.csv", row.names = FALSE)
# # # M <- cor(subset[4:16])
# # # corrplot(M, method="square")