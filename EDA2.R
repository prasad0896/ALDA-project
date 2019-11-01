library(psycho)
stat.df <- read.csv("updatedStatsFrom79OAndD.csv")
wl.df <- read.csv("playoffs.csv")
stat.df[,4:28] <- scale(stat.df[,4:28])
final.df <- data.frame(Year=numeric(),
                       TeamA=character(),
                       TeamB=character(),
                       O_ORebDiff=numeric(),
                       O_DRebDiff=numeric(),
                       O_AsstDiff=numeric(),
                       O_PFDiff=numeric(),
                       O_STLDiff=numeric(),
                       O_TODiff=numeric(),
                       O_BlkDiff=numeric(),
                       O_x3PMDiff=numeric(),
                       O_PtDiff=numeric(),
                       O_FGPDiff=numeric(),
                       O_FTPDiff=numeric(),
                       D_ORebDiff=numeric(),
                       D_DRebDiff=numeric(),
                       D_AsstDiff=numeric(),
                       D_PFDiff=numeric(),
                       D_STLDiff=numeric(),
                       D_TODiff=numeric(),
                       D_BlkDiff=numeric(),
                       D_x3PMDiff=numeric(),
                       D_PtDiff=numeric(),
                       D_FGPDiff=numeric(),
                       D_FTPDiff=numeric(),
                       WL=character(),
                       stringsAsFactors=FALSE)
len <- nrow(wl.df)
for(i in 1:len) {
  year <- wl.df$year[i]
  teamAVal <- factor(wl.df$team_a[i], levels=levels(stat.df$team))
  temp <- stat.df[stat.df$team==teamAVal,]
  AStats <- temp[temp$year==year,]
  #print(AStats[1,2])
  teamBVal <- factor(wl.df$team_b[i], levels=levels(stat.df$team))
  temp <- NULL
  temp <- stat.df[stat.df$team==teamBVal,]
  BStats <- temp[temp$year==year,]
  o_ordiff <- AStats[1,4]-BStats[1,4]
  o_drdiff <- AStats[1,5]-BStats[1,5]
  o_astdiff <- AStats[1,6]-BStats[1,6]
  o_pfdiff <- AStats[1,7]-BStats[1,7]
  o_stldiff <- AStats[1,8]-BStats[1,8]
  o_todiff <- AStats[1,9]-BStats[1,9]
  o_blkdiff <- AStats[1,10]-BStats[1,10]
  o_x3pmdiff <- AStats[1,11]-BStats[1,11]
  o_ptsdiff <- AStats[1,12]-BStats[1,12]
  o_fgpdiff <- AStats[1,25]-BStats[1,25]
  o_ftpdiff <- AStats[1,26]-BStats[1,26]

  d_ordiff <- AStats[1,13]-BStats[1,13]
  d_drdiff <- AStats[1,14]-BStats[1,14]
  d_astdiff <- AStats[1,15]-BStats[1,15]
  d_pfdiff <- AStats[1,16]-BStats[1,16]
  d_stldiff <- AStats[1,17]-BStats[1,17]
  d_todiff <- AStats[1,18]-BStats[1,18]
  d_blkdiff <- AStats[1,19]-BStats[1,19]
  d_x3pmdiff <- AStats[1,20]-BStats[1,20]
  d_ptsdiff <- AStats[1,21]-BStats[1,21]
  d_fgpdiff <- AStats[1,27]-BStats[1,27]
  d_ftpdiff <- AStats[1,28]-BStats[1,28]


  final.df[i,1] <- year
  final.df[i,2] <- levels(teamAVal)[teamAVal]
  final.df[i,3] <- levels(teamBVal)[teamBVal]
  final.df[i,4] <- o_ordiff
  final.df[i,5] <- o_drdiff
  final.df[i,6] <- o_astdiff
  final.df[i,7] <- o_pfdiff
  final.df[i,8] <- o_stldiff
  final.df[i,9] <- o_todiff
  final.df[i,10] <- o_blkdiff
  final.df[i,11] <- o_x3pmdiff
  final.df[i,12] <- o_ptsdiff
  final.df[i,13] <- o_fgpdiff
  final.df[i,14] <- o_ftpdiff
  final.df[i,15] <- d_ordiff
  final.df[i,16] <- d_drdiff
  final.df[i,17] <- d_astdiff
  final.df[i,18] <- d_pfdiff
  final.df[i,19] <- d_stldiff
  final.df[i,20] <- d_todiff
  final.df[i,21] <- d_blkdiff
  final.df[i,22] <- d_x3pmdiff
  final.df[i,23] <- d_ptsdiff
  final.df[i,24] <- d_fgpdiff
  final.df[i,25] <- d_ftpdiff
  final.df[i,26] <- levels(wl.df$wl[i])[wl.df$wl[i]]


}
#final.df <- final.df[order(final.df$Year),]
# final.df <- final.df[ , -which(names(final.df) %in% c("D_FGPDiff","D_PtDiff","O_PtDiff","D_TODiff","D_STLDiff"))]
# write.csv(final.df, file="completeFinalDatasetFrom79_Pruned.csv", row.names = FALSE)

write.csv(final.df, file="completeFinalDatasetFrom79.csv", row.names = FALSE)

# ==========================================================

# stat.df <- read.csv("updatedStatsFrom99.csv")
# wl.df <- read.csv("playoffs.csv")
# wl.df <- wl.df[-which(wl.df$year <= 1998),]
# stat.df[,4:17] <- scale(stat.df[,4:17])
# final.df <- data.frame(Year=numeric(),
#                        TeamA=character(),
#                        TeamB=character(),
#                        O_ORebDiff=numeric(),
#                        O_DRebDiff=numeric(),
#                        O_AsstDiff=numeric(),
#                        O_PFDiff=numeric(),
#                        O_STLDiff=numeric(),
#                        O_TODiff=numeric(),
#                        O_BlkDiff=numeric(),
#                        O_x3PPDiff=numeric(),
#                        O_PtDiff=numeric(),
#                        O_FGPDiff=numeric(),
#                        O_FTPDiff=numeric(),
#                        WL=character(),
#                        stringsAsFactors=FALSE)
# len <- nrow(wl.df)
# for(i in 1:len) {
#   year <- wl.df$year[i]
#   teamAVal <- factor(wl.df$team_a[i], levels=levels(stat.df$team))
#   temp <- stat.df[stat.df$team==teamAVal,]
#   AStats <- temp[temp$year==year,]
#   #print(AStats[1,2])
#   teamBVal <- factor(wl.df$team_b[i], levels=levels(stat.df$team))
#   temp <- NULL
#   temp <- stat.df[stat.df$team==teamBVal,]
#   BStats <- temp[temp$year==year,]
#   o_ordiff <- AStats[1,4]-BStats[1,4]
#   o_drdiff <- AStats[1,5]-BStats[1,5]
#   o_astdiff <- AStats[1,6]-BStats[1,6]
#   o_pfdiff <- AStats[1,7]-BStats[1,7]
#   o_stldiff <- AStats[1,8]-BStats[1,8]
#   o_todiff <- AStats[1,9]-BStats[1,9]
#   o_blkdiff <- AStats[1,10]-BStats[1,10]
#   o_x3ppdiff <- AStats[1,16]-BStats[1,16]
#   o_ptsdiff <- AStats[1,11]-BStats[1,11]
#   o_fgpdiff <- AStats[1,15]-BStats[1,15]
#   o_ftpdiff <- AStats[1,17]-BStats[1,17]
# 
#   final.df[i,1] <- year
#   final.df[i,2] <- levels(teamAVal)[teamAVal]
#   final.df[i,3] <- levels(teamBVal)[teamBVal]
#   final.df[i,4] <- o_ordiff
#   final.df[i,5] <- o_drdiff
#   final.df[i,6] <- o_astdiff
#   final.df[i,7] <- o_pfdiff
#   final.df[i,8] <- o_stldiff
#   final.df[i,9] <- o_todiff
#   final.df[i,10] <- o_blkdiff
#   final.df[i,11] <- o_x3ppdiff
#   final.df[i,12] <- o_ptsdiff
#   final.df[i,13] <- o_fgpdiff
#   final.df[i,14] <- o_ftpdiff
#   final.df[i,15] <- levels(wl.df$wl[i])[wl.df$wl[i]]
# 
# 
# }
# #final.df <- final.df[order(final.df$Year),]
# final.df <- final.df[ , -which(names(final.df) %in% c("O_PtDiff"))]
# # write.csv(final.df, file="completeFinalDatasetFrom79_Pruned.csv", row.names = FALSE)
# 
# write.csv(final.df, file="completeFinalDatasetFrom99_Pruned.csv", row.names = FALSE)

# ==============================================

# stat.df <- read.csv("updatedStatsFrom79.csv")
# wl.df <- read.csv("playoffs.csv")
# stat.df[,4:16] <- scale(stat.df[,4:16])
# final.df <- data.frame(Year=numeric(),
#                        TeamA=character(),
#                        TeamB=character(),
#                        O_ORebDiff=numeric(),
#                        O_DRebDiff=numeric(),
#                        O_AsstDiff=numeric(),
#                        O_PFDiff=numeric(),
#                        O_STLDiff=numeric(),
#                        O_TODiff=numeric(),
#                        O_BlkDiff=numeric(),
#                        O_x3PMDiff=numeric(),
#                        O_PtDiff=numeric(),
#                        O_FGPDiff=numeric(),
#                        O_FTPDiff=numeric(),
#                        WL=character(),
#                        stringsAsFactors=FALSE)
# len <- nrow(wl.df)
# for(i in 1:len) {
#   year <- wl.df$year[i]
#   teamAVal <- factor(wl.df$team_a[i], levels=levels(stat.df$team))
#   temp <- stat.df[stat.df$team==teamAVal,]
#   AStats <- temp[temp$year==year,]
#   #print(AStats[1,2])
#   teamBVal <- factor(wl.df$team_b[i], levels=levels(stat.df$team))
#   temp <- NULL
#   temp <- stat.df[stat.df$team==teamBVal,]
#   BStats <- temp[temp$year==year,]
#   o_ordiff <- AStats[1,4]-BStats[1,4]
#   o_drdiff <- AStats[1,5]-BStats[1,5]
#   o_astdiff <- AStats[1,6]-BStats[1,6]
#   o_pfdiff <- AStats[1,7]-BStats[1,7]
#   o_stldiff <- AStats[1,8]-BStats[1,8]
#   o_todiff <- AStats[1,9]-BStats[1,9]
#   o_blkdiff <- AStats[1,10]-BStats[1,10]
#   o_x3pmdiff <- AStats[1,11]-BStats[1,11]
#   o_ptsdiff <- AStats[1,12]-BStats[1,12]
#   o_fgpdiff <- AStats[1,15]-BStats[1,15]
#   o_ftpdiff <- AStats[1,16]-BStats[1,16]
# 
#   final.df[i,1] <- year
#   final.df[i,2] <- levels(teamAVal)[teamAVal]
#   final.df[i,3] <- levels(teamBVal)[teamBVal]
#   final.df[i,4] <- o_ordiff
#   final.df[i,5] <- o_drdiff
#   final.df[i,6] <- o_astdiff
#   final.df[i,7] <- o_pfdiff
#   final.df[i,8] <- o_stldiff
#   final.df[i,9] <- o_todiff
#   final.df[i,10] <- o_blkdiff
#   final.df[i,11] <- o_x3pmdiff
#   final.df[i,12] <- o_ptsdiff
#   final.df[i,13] <- o_fgpdiff
#   final.df[i,14] <- o_ftpdiff
#   final.df[i,15] <- levels(wl.df$wl[i])[wl.df$wl[i]]
# 
# 
# }
# #final.df <- final.df[order(final.df$Year),]
# final.df <- final.df[ , -which(names(final.df) %in% c("O_PtDiff"))]
# # write.csv(final.df, file="completeFinalDatasetFrom79_Pruned.csv", row.names = FALSE)
# 
# write.csv(final.df, file="completeFinalDatasetFrom79_OnlyO_Pruned.csv", row.names = FALSE)
# 
