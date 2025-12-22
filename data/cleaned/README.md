# Cleaned Dataset

This folder contains the analysis-ready version of the hospital readmission dataset.

## Cleaning and Preparation Steps
- Selected relevant clinical and operational variables required for readmission analysis
- Renamed reserved SQL keyword `change` to `med_change` for compatibility and clarity
- Standardized column structure for use across SQL and R workflows
- Preserved original readmission categories (<30, >30, NO) for outcome analysis

## Purpose
The cleaned dataset was created to support:
- SQL-based KPI calculation
- Exploratory data analysis in R
- Visualization and dashboard development

The original raw dataset is retained separately in the `data/raw/` folder to preserve data integrity.
