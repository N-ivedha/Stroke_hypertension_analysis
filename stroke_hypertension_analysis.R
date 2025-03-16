####Stroke_Hypertension_Analysis########
# Define required packages
required_packages <- c("tidyverse", "readxl", "ggplot2", "dplyr", "summarytools")

# Install only if missing
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
}

# Apply function to all required packages
invisible(lapply(required_packages, install_if_missing))

# Load installed packages
library(tidyverse)   # For data manipulation & visualization
library(readxl)      # To read Excel files
library(ggplot2)     # For plotting
library(dplyr)       # For data wrangling
library(summarytools) # For summary statistics

install.packages("summarytools", dependencies = TRUE)

library(readxl)

df <- read_excel("D:\project\Stroke_Hypertension_Analysis.xlsx")  #actual file path

head(df)  # Preview the dataset

df <- read_excel(file.choose())
library(readxl)
df <- read_excel(file.choose())

excel_sheets("D:\project\Stroke_Hypertension_Analysis.xlsx")
stroke_data <- read_excel("Stroke_Hypertension_Analysis.xlsx", sheet = 1)

# View the first few rows
head(df)

# Check column names
colnames(df)

# Check structure (data types of each column)
str(df)

# Get a summary of numeric columns
summary(df)

# Count missing values in each column
colSums(is.na(df))

# Remove extra unnamed columns (if they exist)
df <- df[, colSums(is.na(df)) < nrow(df)]  # Keeps only columns that are not entirely NA

# Check missing values again
colSums(is.na(df))

# Remove extra unnamed columns by selecting only the relevant ones
df <- df %>% select(sex, age, hypertension, avg_glucose_level, bmi, smoking_status, stroke)

# Check again to confirm
colSums(is.na(df))

library(dplyr)  # Load dplyr package

df <- df %>% select(sex, age, hypertension, avg_glucose_level, bmi, smoking_status, stroke)
colSums(is.na(df))

head(df)  # Show the first few rows
str(df)   # Check the structure of the dataset

#Converting Numeric Categorical Variables to Factors
df <- df %>%
  mutate(
    sex = factor(sex, labels = c("Female", "Male")),
    hypertension = factor(hypertension, labels = c("No", "Yes")),
    smoking_status = factor(smoking_status, labels = c("Non-Smoker", "Smoker")),
    stroke = factor(stroke, labels = c("No Stroke", "Stroke"))
  )

sapply(df[, c("sex", "hypertension","avg_glucose_level","bmi", "smoking_status", "stroke")], unique)

str(df)
head(df)

#ensuring they are explicitly set as factors
df$sex <- as.factor(df$sex)
df$hypertension <- as.factor(df$hypertension)
df$smoking_status <- as.factor(df$smoking_status)
df$stroke <- as.factor(df$stroke)

df <- df %>%
  mutate(
    hypertension = factor(hypertension, labels = c("No", "Yes")),
    smoking_status = factor(smoking_status, labels = c("Non-Smoker", "Smoker")),
    stroke = factor(stroke, labels = c("No Stroke", "Stroke")),
    bmi_category = case_when(
      bmi < 18.5 ~ "Underweight",
      bmi >= 18.5 & bmi < 25 ~ "Normal",
      bmi >= 25 & bmi < 30 ~ "Overweight",
      bmi >= 30 ~ "Obese",
      TRUE ~ NA_character_
    )
  )
str(df) #confirming properly converted to factors

#Remove rows with missing values
df <- na.omit(df)  # Removes all rows with any missing values
#Confirm Changes
str(df)   # Check if categorical variables are now factors
colSums(is.na(df))  # Verify no missing values remain

summary(df)

df <- df[df$age >= 0, ]#negative age value
df$bmi_category <- as.factor(df$bmi_category)#categorical to factor
str(df)


#compare BMI and glucose levels between hypertensive and non-hypertensive stroke patients
library(dplyr)

df %>%
  group_by(hypertension) %>%
  summarise(
    Mean_BMI = mean(bmi, na.rm = TRUE),
    Mean_Glucose = mean(avg_glucose_level, na.rm = TRUE),
    Count = n()
  )

#boxplots for bmi and glucose
library(ggplot2)

# Boxplot for BMI
ggplot(df, aes(x = factor(hypertension), y = bmi, fill = factor(hypertension))) +
  geom_boxplot() +
  labs(title = "BMI Distribution: Hypertensive vs. Non-Hypertensive Stroke Patients",
       x = "Hypertension (0 = No, 1 = Yes)",
       y = "BMI") +
  theme_minimal()

# Boxplot for Glucose Levels
ggplot(df, aes(x = factor(hypertension), y = avg_glucose_level, fill = factor(hypertension))) +
  geom_boxplot() +
  labs(title = "Glucose Level Distribution: Hypertensive vs. Non-Hypertensive Stroke Patients",
       x = "Hypertension (0 = No, 1 = Yes)",
       y = "Glucose Level") +
  theme_minimal()

library(ggplot2)
# Boxplot for Glucose Levels
ggplot(df, aes(x = factor(hypertension), y = avg_glucose_level, fill = factor(hypertension))) +
  geom_boxplot() +
  labs(title = "Glucose Level Distribution: Hypertensive vs. Non-Hypertensive Stroke Patients",
       x = "Hypertension (0 = No, 1 = Yes)",
       y = "Glucose Level") +
  theme_minimal()

#Compare Smokers: Bar Chart
ggplot(df, aes(x = factor(hypertension), fill = factor(smoking_status))) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Smokers Among Hypertensive & Non-Hypertensive Stroke Patients",
       x = "Hypertension (0 = No, 1 = Yes)",
       y = "Proportion",
       fill = "Smoking Status") +
  theme_minimal()

#Statistical tests
#t-test (Compare BMI & Glucose between groups)
t.test(bmi ~ hypertension, data = df)  
t.test(avg_glucose_level ~ hypertension, data = df)  

# box plot for glucse levels
# Load ggplot2
library(ggplot2)

# Boxplot for Glucose Levels
ggplot(df, aes(x = factor(hypertension), y = avg_glucose_level, fill = factor(hypertension))) +
  geom_boxplot() +
  labs(title = "Glucose Level Distribution: Hypertensive vs. Non-Hypertensive Patients",
       x = "Hypertension (No = 0, Yes = 1)",
       y = "Glucose Level") +
  theme_minimal()

#Regression analysis(Hypertension & Glucose Level)
# Linear regression model
model <- lm(avg_glucose_level ~ hypertension, data = df)

# Summary of regression
summary(model)

model2 <- lm(avg_glucose_level ~ hypertension + age + bmi + smoking_status, data = df)
summary(model2)



#Chi-Square Tests: Hypertension & Other Factors on Stroke
table_hyp_stroke <- table(df$hypertension, df$stroke)#hypertension
chisq.test(table_hyp_stroke)

table_smoke_stroke <- table(df$smoking_status, df$stroke)#Smoking Status vs. Stroke
chisq.test(table_smoke_stroke)

table_bmi_stroke <- table(df$bmi_category, df$stroke) #BMI Category vs. Stroke
chisq.test(table_bmi_stroke)

#Stacked bar plots for chi-square tests
# Load required libraries
library(ggplot2)
library(dplyr)

# Stacked Bar Plot: Hypertension vs. Stroke
ggplot(df, aes(x = hypertension, fill = stroke)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Stroke Cases Among Hypertensive & Non-Hypertensive Patients",
       x = "Hypertension (No = 0, Yes = 1)",
       y = "Proportion",
       fill = "Stroke Status") +
  theme_minimal()

# Stacked Bar Plot: Smoking Status vs. Stroke
ggplot(df, aes(x = smoking_status, fill = stroke)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Stroke Cases by Smoking Status",
       x = "Smoking Status",
       y = "Proportion",
       fill = "Stroke Status") +
  theme_minimal()

# Stacked Bar Plot: BMI Category vs. Stroke
ggplot(df, aes(x = bmi_category, fill = stroke)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Stroke Cases by BMI Category",
       x = "BMI Category",
       y = "Proportion",
       fill = "Stroke Status") +
  theme_minimal()



