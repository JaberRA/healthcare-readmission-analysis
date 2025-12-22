# Healthcare Readmission Risk Analysis

## Project Overview
Hospital readmissions within 30 days are a major quality and cost concern in healthcare systems. This project analyzes patient-level healthcare data to identify patterns and risk factors associated with hospital readmissions. The goal is to support data-driven decision-making that can help reduce avoidable readmissions and improve patient outcomes.

## Objectives
- Analyze hospital readmission trends using structured healthcare data  
- Identify high-risk patient groups based on demographic and clinical factors  
- Perform SQL-based analysis to answer operational healthcare questions  
- Conduct exploratory data analysis using R  
- Present findings through clear and meaningful visualizations  

## Tools & Technologies
- SQL (MySQL-style syntax)
- R (tidyverse, ggplot2)
- Excel (data validation and preprocessing)
- GitHub (version control and documentation)

## Project Structure
healthcare-readmission-analysis/
├── data/
│   ├── raw/
│   └── cleaned/
├── sql/
├── r_analysis/
├── dashboard/
└── README.md

## Expected Outcomes
- Clear identification of factors contributing to hospital readmissions  
- Actionable insights for healthcare administrators and analysts  
- A reproducible analytical workflow suitable for healthcare analytics roles  

## Key Findings

### 1. Overall Readmission Burden
- Approximately **11.07%** of hospital encounters resulted in a **30-day readmission**.
- This rate is clinically significant and aligns with benchmarks observed in chronic disease populations such as diabetes.

### 2. Age-Based Risk Patterns
- Readmission risk increases notably after age 60.
- Patients aged **70–90 years** consistently showed higher 30-day readmission rates, highlighting the need for enhanced discharge planning and post-acute care coordination for older adults.

### 3. Impact of Length of Hospital Stay
- Patients with longer hospital stays experienced progressively higher readmission rates.
- Readmission risk increased from **~8% for 1-day stays** to **~14% for stays longer than 8 days**, suggesting that clinical complexity strongly influences post-discharge outcomes.

### 4. Medication Burden and Polypharmacy
- A clear positive relationship was observed between the number of medications prescribed and readmission risk.
- Patients receiving **21 or more medications** had a **30-day readmission rate exceeding 12%**, emphasizing the importance of medication reconciliation and pharmacy-led interventions.

## Visual Analysis

### 30-Day Readmission Rate by Age Group
![Readmission by Age](dashboard/screenshots/readmission_by_age.png)

### 30-Day Readmission Rate by Length of Hospital Stay
![Readmission by Length of Stay](dashboard/screenshots/readmission_by_length_of_stay.png)

### 30-Day Readmission Rate by Medication Burden
![Readmission by Medication Burden](dashboard/screenshots/readmission_by_medication_burden.png)

## Skills Demonstrated

- Healthcare data analysis using de-identified hospital encounter data
- SQL-based KPI development and risk stratification analysis
- Exploratory data analysis and visualization using R (tidyverse, ggplot2)
- Identification of high-risk patient profiles using combined clinical and operational factors
- Reproducible analytics workflow with clear documentation and version control


## Disclaimer
This project uses publicly available, de-identified data for educational and portfolio purposes only. No protected health information (PHI) is included.
