# Stroke & Hypertension Data Analysis

## Project Overview  
This project analyzes stroke and hypertension trends using **Excel and R**, focusing on **age, BMI, blood pressure, and lifestyle factors** to identify risk factors and build a **predictive model**.

---

## Dataset Information  
- **Filename**: `stroke_data.csv`  
- **Source**: [Kaggle - Hypertension Dataset](https://www.kaggle.com/)  
- **License**: CC0 (Public Domain) – Free for use without restrictions.  
- **Contents**: Patient demographics, BMI, hypertension status, stroke history, and other health metrics.  

---

## Key Analyses Conducted  
### **Excel Analysis**  
- **Data Cleaning** (handling missing values, duplicates)  
- **Pivot Tables** for trends in stroke & hypertension  
- **Descriptive Statistics** (mean, median, mode)  
- **Charts & Graphs** for visualization  

### **R Analysis**  
- **T-tests & Boxplots**: Comparing BMI & Glucose levels  
- **Chi-Square Test**: Association between hypertension, smoking, and stroke  
- **Regression Model**: Predicting glucose levels  
- **Data Visualization**: Stacked bar plots & distribution analysis  

---

## Repository Structure  
Stroke_Hypertension_Analysis/
│-- data/
│   ├── hypertension_data.xlsx        # Raw dataset
│   ├── hypertension_cleaned.xlsx     # Processed dataset
│-- notebooks/
│   ├── analysis_in_r.Rmd             # R analysis
│   ├── analysis_in_excel.xlsx        # Excel analysis
│-- plots/
│   ├── boxplot_glucose.png           # Boxplot for glucose levels
│   ├── chi_square_plot.png           # Chi-square test visualization
│-- README.md                         # Project documentation


---

## **Final Insights & Findings**  
🔹 **Hypertensive patients** had significantly higher **glucose levels** (p < 2.2e-16).  
🔹 **BMI** & **Smoking** showed a strong association with stroke occurrence.  
🔹 **Age** was not a strong predictor in our regression model.  
🔹 **Chi-Square Tests** confirmed hypertension as a major risk factor.  

---
## **Power BI Dashboard
This project now includes an interactive Power BI dashboard with:

- Pie Chart: Count of strokes by hypertension status  
- Clustered Column Chart: Stroke counts split by hypertension (clear visual association)  
- Stacked Bar Chart: Stroke count by BMI category and smoking status  
- Card: Chi-Square test result (p < 0.001, significant association)


##  **How to Run the Analysis**  

### **Using Excel**  
1️⃣ Open `notebooks/analysis_in_excel.xlsx`  
2️⃣ Explore **Pivot Tables, Graphs & Summary Stats**  

### **Using R**  
1️⃣ Install required R packages (`dplyr`, `ggplot2`, etc.)  
2️⃣ Run `notebooks/analysis_in_r.Rmd`  

---

##  **Next Steps**  
🔹 Enhance the model with **logistic regression**  
🔹 Add **more visualizations** (correlation heatmaps, trends)  
🔹 Integrate **machine learning models** for better predictions  

---

 **Contributors**: *Nivedha V*  
 **Check out the repository**: [GitHub Link](https://github.com/N-ivedha/Stroke_hypertension_analysis)  

---

 




