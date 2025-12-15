# Data Dictionary – Diabetes Readmission Dataset

## Dataset Description
This dataset contains de-identified patient encounter data collected from 130 U.S. hospitals between 1999 and 2008. Each row represents a single hospital encounter for a patient diagnosed with diabetes.

## Key Variables

### encounter_id
A unique identifier assigned to each hospital encounter.

### patient_nbr
A unique identifier for each patient. This allows multiple encounters for the same patient to be tracked without revealing identity.

### race
Patient-reported race category.

### gender
Patient-reported gender.

### age
Age group of the patient represented in ranges (e.g., [50–60), [60–70)).

### admission_type_id
Indicates the type of admission, such as emergency, urgent, or elective.

### discharge_disposition_id
Describes how the patient was discharged (e.g., home, transferred, expired).

### time_in_hospital
Number of days the patient stayed in the hospital during the encounter.

### num_lab_procedures
Total number of laboratory tests performed during the encounter.

### num_medications
Number of medications administered during the encounter.

### number_diagnoses
Total number of diagnoses recorded for the patient.

### readmitted
Indicates whether the patient was readmitted within 30 days, after 30 days, or not readmitted.
