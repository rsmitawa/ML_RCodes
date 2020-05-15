# Adding PCA for Numeric Features
library(ggplot2)
library(ggfortify)
pca_train_df <- prcomp(x = x_train_df[-1], scale. = TRUE)
autoplot(pca_train_df, data = train_df, colour = "Survived", loadings = TRUE)
pca_matric <- (pca_train_df$sdev ^ 2) / sum((pca_train_df$sdev ^ 2))
plot(pca_matric)
plot(cumsum(pca_matric))
train_data <- data.frame(pca_train_df$x[,1:32], Dependent_Variable = y_train_df$Dependent_Variable)

----------------------------------------------------------------------------------------------------------------------------------

rpart_model <- rpart::rpart(formula = Dependent_Variable ~ ., data = train_data, method = "class")
fancyRpartPlot(rpart_model)

rf_predictions <- predict(object = rpart_model, newdata = train_data[-33], type = "class")  

--------------------------------------------------------------------------------------------------------------------------------

# Logistic Regression

logistic_model <- glm(formula = Survived ~., data = train_df[-2], family = binomial(link = "logit"))
summary(logistic_model)

prediction_train <- predict(object = logistic_model, newdata = train_df[-c(1:2)], type = "response")
prediction_test <- predict(object = logistic_model, newdata = test_df[-c(1:2)], type = "response")

output_train_logistic <- data.frame(predicted = ifelse(prediction_train > 0.5, 1, 0), actual = train_df$Survived)
output_test_logistic <- data.frame(predicted = ifelse(prediction_test > 0.5, 1, 0), actual = test_df$Survived)

caret::confusionMatrix(table(output_train_logistic))$byClass # Accuracy : 0.8301, F1 : 0.8597914
caret::confusionMatrix(table(output_test_logistic))$byClass #  Accuracy : 0.8268, F1 :  0.8724280 



