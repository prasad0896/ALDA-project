# ALDA Project SVM
library("e1071")
library("caret")
library("rlist")
library("plotly")
library("pROC")
library("ROCR")
cat('\014')
rm(list=ls())

data <- read.csv("completeFinalDatasetFrom79.csv")
# summary(data)
data.df <- data[4:26]
data.df$WL <- factor(data.df$WL, levels = c("L","W"), labels = c("-1","1"))
# head(data.df)
# obj <- tune(svm, WL~., data = data.df, 
#             ranges = list(gamma = 2^(-1:1), cost = 2^(2:4)),
#             tunecontrol = tune.control(sampling = "bootstrap")
# )

print("TSCV Accuracy for SVM - Linear Kernel")
cost <- -15
res.df <- data.frame(Cost=numeric(),
                      Accuracy=numeric(),
                      Recall = numeric(),
                      AUC=numeric(),
                      stringsAsFactors=FALSE)
i <- 1
while(cost <= 10) {
  ctr <- 0
  actuals <- NULL
  preds <- NULL
  while(ctr < 300) {
    train.df <- data.df[1:(75+ctr),]
    # print(1:(75+ctr))
    test.df <- data.df[(75+ctr+1):(75+ctr+75),]
    # print((75+ctr+1):(75+ctr+75))
    classifier <- svm(formula = WL ~ .,
                      data = train.df,
                      type = 'C-classification',
                      kernel = 'linear',
                      cost = 2^cost)
    y_pred = predict(classifier, newdata = test.df[-ncol(test.df)])
    preds <- list.append(preds, y_pred)
    actuals <- list.append(actuals, test.df[,ncol(test.df)])
    ctr <- ctr + 75
  }
  actuals <- actuals[-length(actuals)]
  cm = table(actuals, preds)
  res.df[i,1] <- 2^cost
  res.df[i,2] <- mean(actuals == preds)
  if(length(cm) == 4) {
    res.df[i,3] <- cm[4] / (cm[3]+cm[4])
  } else {
    res.df[i,3] <- cm[2] / (cm[1]+cm[2])
  }
  roc_obj <- roc(actuals, preds)
  res.df[i,4] <- auc(roc_obj)
  #print(cm)
  cost <- cost + 1
  i <- i+1
}
print(res.df[res.df[2] == max(res.df[,2])])
print(res.df[res.df[4] == max(res.df[,4])])
attach(res.df)
new.res <- res.df[order(AUC),]
detach(res.df)
write.csv(new.res, file="SVMHyperParLinear.csv", row.names = FALSE)
#plot(x = log2(res.df$Cost), y = res.df$Accuracy, type = "l", xlab = "Cost (power of 2)", ylab = "TSCV Accuracy", main = "Cost for Linear Kernel", col = "brown")
plot(x = log2(res.df$Cost), y = scale(res.df$AUC), type = "l", xlab = "Cost (power of 2)", ylab = "Scaled TSCV AUC and Accuracy", main = "Cost for Linear Kernel vs AUC and Accuracy", col = "brown")
lines(x = log2(res.df$Cost), y = scale(res.df$Accuracy), col = "green")
points(x = log2(0.25), y = scale(res.df$AUC)[14], col = "blue")
points(x = log2(0.25), y = scale(res.df$Accuracy)[14], col = "blue")
legend(-15, 1.2, legend=c("AUC", "Accuracy"),
       col=c("brown", "green"), lty=1:2, cex=0.8)

print("TSCV Accuracy for SVM - Radial Kernel")

gamma <- -15
gammas <- NULL
costs <- NULL
accuracies <- NULL
i <- 1
res.df <- data.frame(Cost=numeric(),
                       Gamma=numeric(),
                       Accuracy=numeric(),
                       AUC=numeric(),
                       stringsAsFactors=FALSE)

while(gamma <= 3) {
  cost <- -15
  while(cost <= 10) {
    ctr <- 0
    actuals <- NULL
    preds <- NULL
    while(ctr < 300) {
      train.df <- data.df[1:(75+ctr),]
      # print(1:(75+ctr))
      test.df <- data.df[(75+ctr+1):(75+ctr+75),]
      # print((75+ctr+1):(75+ctr+75))
      classifier <- svm(formula = WL ~ .,
                        data = train.df,
                        type = 'C-classification',
                        kernel = 'radial',
                        cost = 2^cost,
                        gamma = 2^gamma)
      y_pred = predict(classifier, newdata = test.df[-ncol(test.df)])
      preds <- list.append(preds, y_pred)
      actuals <- list.append(actuals, test.df[,ncol(test.df)])
      ctr <- ctr + 75
    }
    actuals <- actuals[-length(actuals)]
    cm = table(actuals, preds)
    res.df[i,1] <- 2^cost
    res.df[i,2] <- 2^gamma
    res.df[i,3] <- mean(actuals == preds)
    roc_obj <- roc(actuals, preds)
    res.df[i,4] <- auc(roc_obj)
    cost <- cost + 1
    i <- i + 1
  }
  gamma <- gamma + 1
}
print(res.df[res.df[3] == max(res.df[,3])])
print(res.df[res.df[4] == max(res.df[,4])])
attach(res.df)
new.res <- res.df[order(AUC),]
detach(res.df)
write.csv(new.res, file="SVMHyperParRadial.csv", row.names = FALSE)
plot_ly(res.df, x = ~Cost, y = ~Gamma, z = ~Accuracy, marker = list(color = ~Accuracy, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Cost'),
                      yaxis = list(title = 'Gamma'),
                      zaxis = list(title = 'Accuracy')))
plot_ly(res.df, x = ~Cost, y = ~Gamma, z = ~AUC, marker = list(color = ~AUC, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Cost'),
                      yaxis = list(title = 'Gamma'),
                      zaxis = list(title = 'AUC')))
plot_ly(res.df, x = ~Cost, y = ~Gamma, z = ~Accuracy, marker = list(color = ~AUC, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Cost'),
                      yaxis = list(title = 'Gamma'),
                      zaxis = list(title = 'Accuracy')))


print("TSCV Accuracy for SVM - Sigmoid Kernel")

gamma <- -15
gammas <- NULL
costs <- NULL
accuracies <- NULL
i <- 1
res.df <- data.frame(Cost=numeric(),
                     Gamma=numeric(),
                     Accuracy=numeric(),
                     AUC=numeric(),
                     stringsAsFactors=FALSE)

while(gamma <= 3) {
  cost <- -15
  while(cost <= 10) {
    ctr <- 0
    actuals <- NULL
    preds <- NULL
    while(ctr < 300) {
      train.df <- data.df[1:(75+ctr),]
      # print(1:(75+ctr))
      test.df <- data.df[(75+ctr+1):(75+ctr+75),]
      # print((75+ctr+1):(75+ctr+75))
      classifier <- svm(formula = WL ~ .,
                        data = train.df,
                        type = 'C-classification',
                        kernel = 'sigmoid',
                        cost = 2^cost,
                        gamma = 2^gamma)
      y_pred = predict(classifier, newdata = test.df[-ncol(test.df)])
      preds <- list.append(preds, y_pred)
      actuals <- list.append(actuals, test.df[,ncol(test.df)])
      ctr <- ctr + 75
    }
    actuals <- actuals[-length(actuals)]
    cm = table(actuals, preds)
    res.df[i,1] <- 2^cost
    res.df[i,2] <- 2^gamma
    res.df[i,3] <- mean(actuals == preds)
    roc_obj <- roc(actuals, preds)
    res.df[i,4] <- auc(roc_obj)
    cost <- cost + 1
    i <- i + 1
  }
  gamma <- gamma + 1
}
print(res.df[res.df[3] == max(res.df[,3])])
print(res.df[res.df[4] == max(res.df[,4])])
attach(res.df)
new.res <- res.df[order(AUC),]
detach(res.df)
write.csv(new.res, file="SVMHyperParSigmoid.csv", row.names = FALSE)
plot_ly(res.df, x = ~Cost, y = ~Gamma, z = ~Accuracy, marker = list(color = ~Accuracy, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Cost'),
                      yaxis = list(title = 'Gamma'),
                      zaxis = list(title = 'Accuracy')))
plot_ly(res.df, x = ~Cost, y = ~Gamma, z = ~AUC, marker = list(color = ~AUC, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Cost'),
                      yaxis = list(title = 'Gamma'),
                      zaxis = list(title = 'AUC')))
plot_ly(res.df, x = ~Cost, y = ~Gamma, z = ~Accuracy, marker = list(color = ~AUC, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Cost'),
                      yaxis = list(title = 'Gamma'),
                      zaxis = list(title = 'Accuracy')))

# Train:Test 70:30
train.df <- data.df[1:262,]
test.df <- data.df[263:374,]

# Best Linear SVM model 2 One of the best AUCs
classifier <- svm(formula = WL ~ .,
                  data = train.df,
                  type = 'C-classification',
                  kernel = 'linear',
                  cost = 0.25)
y_pred = predict(classifier, newdata = test.df[-ncol(test.df)])
cm = table(test.df[,ncol(test.df)], y_pred)
print(cm)
print(mean(test.df[,ncol(test.df)] == y_pred))


# Best Radial SVM model 2 (High AUC)
classifier <- svm(formula = WL ~ .,
                  data = train.df,
                  type = 'C-classification',
                  kernel = 'radial',
                  cost = 2,
                  gamma = 0.03125)
y_pred = predict(classifier, newdata = test.df[-ncol(test.df)])
cm = table(test.df[,ncol(test.df)], y_pred)
print(cm)
print(mean(test.df[,ncol(test.df)] == y_pred))


# Best Sigmoid SVM model
classifier <- svm(formula = WL ~ .,
                  data = train.df,
                  type = 'C-classification',
                  kernel = 'sigmoid',
                  cost = 16,
                  gamma = 0.015625)
y_pred = predict(classifier, newdata = test.df[-ncol(test.df)])
cm = table(test.df[,ncol(test.df)], y_pred)
print(cm)
print(mean(test.df[,ncol(test.df)] == y_pred))