# # Exploratory Data Analysis 3
# library(corrplot)
# df <- read.csv("completeFinalDatasetFrom79.csv")
# # 
# subset <- df[4:26]
# subset <- subset[1:22]
# subset <- subset[ , -which(names(subset) %in% c("D_FGPDiff","D_PtDiff","O_PtDiff","D_TODiff","D_STLDiff"))]
# M <- cor(subset)
# # 
# # # Corr Plots
# corrplot(M, method="square")
# # summary(df)
# # 
# # # Density plots
# # library(caret)
# # x <- df[,4:14]
# # y <- df[,15]
# # scales <- list(x=list(relation="free"), y=list(relation="free"))
# # featurePlot(x=x, y=y, plot="density", scales=scales)
# # 
# # glm.fit <- glm(WL ~ ORebDiff + DRebDiff + AsstDiff + PFDiff + STLDiff + TODiff + BlkDiff + X3PMDiff + PtDiff + FGPDiff + FTPDiff, data = df, family = "binomial")
# # summary(glm.fit)
# # glm.probs <- predict(glm.fit, type = "response")
# # glm.pred <- ifelse(glm.probs > 0.5, "W", "L")
# # attach(df)
# # table(glm.pred,WL)
# # print(length(WL))
# # print(length(glm.pred))
# # 
# # mean(glm.pred == WL)

# ==========================================================

# Exploratory Data Analysis 3
library(corrplot)
df <- read.csv("completeFinalDatasetFrom79_OnlyO.csv")
# 
subset <- df[4:14]
# subset <- subset[1:22]
subset <- subset[ , -which(names(subset) %in% c("O_PtDiff"))]
M <- cor(subset)
# # 
# # # Corr Plots
corrplot(M, method="square")
# # summary(df)
# # 
# # # Density plots
# # library(caret)
# # x <- df[,4:14]
# # y <- df[,15]
# # scales <- list(x=list(relation="free"), y=list(relation="free"))
# # featurePlot(x=x, y=y, plot="density", scales=scales)
# # 
# # glm.fit <- glm(WL ~ ORebDiff + DRebDiff + AsstDiff + PFDiff + STLDiff + TODiff + BlkDiff + X3PMDiff + PtDiff + FGPDiff + FTPDiff, data = df, family = "binomial")
# # summary(glm.fit)
# # glm.probs <- predict(glm.fit, type = "response")
# # glm.pred <- ifelse(glm.probs > 0.5, "W", "L")
# # attach(df)
# # table(glm.pred,WL)
# # print(length(WL))
# # print(length(glm.pred))
# # 
# # mean(glm.pred == WL)