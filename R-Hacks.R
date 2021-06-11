# Read zip file directy in R using fread
main_df <- as.data.frame(fread(input = "unzip -p operations.csv.zip", stringsAsFactors = TRUE, nThread = 8))

# compare two dataframes, if they are same or identical

base::table(df1 == df2, useNA = "ifany")
# True count, False count, and null count

base::identical(df1, df2)
# TRUE, FALSE

base::all.equal(df1, df2)
# True or mismatch column name
