# Creating dummy vars of factors
feature_df <- fastDummies::dummy_cols(.data = feature_df, select_columns = colnames(select_if(feature_df, is.factor)), 
                                      remove_first_dummy = TRUE, ignore_na = TRUE, remove_selected_columns = TRUE)
