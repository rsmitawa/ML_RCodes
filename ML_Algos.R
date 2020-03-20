# Adding PCA for Numeric Features
pca_train_df <- prcomp(x = x_train_df[-1], scale. = TRUE)
  pca_matric <- (pca_train_df$sdev ^ 2) / sum((pca_train_df$sdev ^ 2))
plot(pca_matric)
plot(cumsum(pca_matric))
train_data <- data.frame(pca_train_df$x[,1:32], Dependent_Variable = y_train_df$Dependent_Variable)

rpart_model <- rpart::rpart(formula = Dependent_Variable ~ ., data = train_data, method = "class")
fancyRpartPlot(rpart_model)

rf_predictions <- predict(object = rpart_model, newdata = train_data[-33], type = "class")  


