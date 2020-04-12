# Read zip file directy in R using fread
main_df <- as.data.frame(fread(input = "unzip -p operations.csv.zip", stringsAsFactors = TRUE, nThread = 8))
