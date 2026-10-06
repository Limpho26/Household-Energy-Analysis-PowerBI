# Household-Energy-Analysis-PowerBI
Interactive Power BI analysis of household gas and electricity consumption, incorporating temperature data, SQL, DAX and star-schema modelling.
# Household Energy Consumption Analysis

## Project Overview

This project analyses household Gas and Electricity consumption to identify usage patterns, anomalies, seasonal trends and opportunities for improved energy efficiency.

The analysis combines hourly household energy consumption with outdoor temperature data and presents the findings through an interactive Power BI dashboard.

## Tools & Technologies

- Power BI
- Power Query
- DAX
- SQL Server
- Data Modelling
- Data Visualisation

## Data Model

A star-schema approach was used to structure the analytical model.

The model consists of:

- FactEnergy
- FactTemperature
- DimDate
- DimTime
- DimEnergyType

Energy and Temperature were maintained as separate fact tables because they have different grains. Energy observations are recorded by Date, Hour and Energy Type, while Temperature observations are recorded by Date and Hour.

Shared Date and Time dimensions allow both datasets to be analysed together without unnecessarily duplicating temperature observations.

## Dashboard

The Power BI report contains two main analytical pages:

### 1. Energy Overview

Provides a high-level view of household energy consumption, including:

- Total Gas and Electricity consumption
- Monthly energy trends
- Hourly consumption patterns
- Day-of-week patterns
- Weekday vs Weekend consumption
- Daily consumption as a percentage of monthly consumption

### 2. Weather & Energy Analysis

Explores the relationship between outdoor temperature and energy consumption, including:

- Monthly temperature trends
- Gas consumption vs temperature
- Electricity consumption vs temperature
- Scatter plots and trend analysis

## Key Findings

- Total recorded energy consumption was approximately 15.61K.
- Electricity represented approximately 90% of recorded consumption.
- Gas consumption showed a clear negative relationship with outdoor temperature, consistent with increased heating demand during colder periods.
- Electricity consumption showed a weaker relationship with temperature, suggesting that other household behaviours and appliance usage influence consumption.
- Higher Electricity consumption was observed during some early-morning hours and was identified as an area for further investigation.

## Data Quality

Several data-quality considerations were incorporated into the analysis:

- Fully blank records were removed.
- Zero consumption values were retained because zero does not necessarily represent missing data.
- Incomplete months were identified and excluded from calculations requiring complete monthly data.
- Temperature readings potentially affected by direct sunlight were retained but treated as an analytical limitation.

## SQL

An accompanying SQL Server script demonstrates how the fact and dimension tables could be prepared in SQL before being imported into Power BI.

The script includes examples of:

- Dimension table creation
- Fact table preparation
- Date transformations
- NULL handling
- Natural-grain preparation

## Recommendations

Based on the analysis:

- Review heating schedules and thermostat settings during colder periods.
- Investigate early-morning Electricity consumption and scheduled appliance loads.
- Consider insulation and draught-proofing improvements.
- Review hot-water scheduling.
- Incorporate energy tariff data in future analysis to translate consumption reductions into financial savings.

## Skills Demonstrated

- Data Cleaning & Transformation
- Power BI Dashboard Development
- Power Query
- DAX
- SQL
- Star-Schema Data Modelling
- Data Quality Analysis
- Exploratory Data Analysis
- Business Insight Generation
- Data Visualisation
