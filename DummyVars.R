# Creating dummy vars of factors
feature_df <- fastDummies::dummy_cols(.data = feature_df, select_columns = colnames(select_if(feature_df, is.factor)), 
                                      remove_first_dummy = TRUE, ignore_na = TRUE, remove_selected_columns = TRUE)

# Scaling of a df
x_train_df[-1] <- scale(x = x_train_df[-1]) 

# Mean Imputation for NAs
for(i in 1:ncol(x_train_df)){
  x_train_df[is.na(x_train_df[,i]), i] <- mean(x_train_df[,i], na.rm = TRUE)
}

# Check total NAs and filter Columns with NAs
tot <- colSums(is.na(x_main_df))
colnames(x_main_df)[tot > 0]


# Sampling of Train Set and Test Set
index <- sample(x = 1:nrow(x_train_df), size = 0.80*nrow(x_train_df))
x_train <- x_train_df[index,]
x_test <- x_train_df[-index,]

# Logistic Regression Model with Cross Validation
logistic_model <- glmnet(x = as.matrix(x_train[-1]), y = y_train$Dependent_Variable, family = "binomial")
train_auc <- predict.glmnet(logistic_model, newx = as.matrix(x_train[-1]), type = "class")
cvfit = cv.glmnet(x = as.matrix(x_train[-1]), y = y_train$Dependent_Variable, family = "binomial", type.measure = "class")
plot(cvfit)
pred <- as.vector(predict(cvfit, newx = as.matrix(x_train[-1]), s = "lambda.min", type = "class"))


liner_regularized_models <- list()
for(i in 0:10){
  fit_name <- paste("alpha", i/10, sep = "_")
  liner_regularized_models[[fit_name]] <- cv.glmnet(x = as.matrix(x_train[-1]), 
                                                    y = y_train$Dependent_Variable,
                                                    type.measure = "mse",
                                                    parallel = TRUE,
                                                    family = "binomial",
                                                    alpha = i/10) 
}

# KNN Imputation ----------------------------------------------------------
knnOutput <- knnImputation(data = x_train_df[-1])
knnOutput$Dependent_Variable <- y_train_df$Dependent_Variable

