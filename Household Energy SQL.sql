/*
Household Energy Analysis
Example SQL Server script for generating semantic-model import tables.

Assumptions
1. Raw energy table: dbo.EnergyUse
2. Raw temperature table: dbo.Temperature
3. Energy columns: [Date], [Hour], [Energy Type], [Consumption]
4. Temperature columns: [Date], [Hour], [Temperature C]

Data-quality approach
- Exclude records missing fields required at each table's natural grain.
- Preserve zero consumption: zero is a valid value and is not NULL.
- Do not automatically delete unusually high temperature readings; direct sunlight
  may overstate ambient temperature, so this is documented as an analysis limitation.
*/

/* 1. DimEnergyType — one row per energy type */
WITH EnergyTypes AS (
    SELECT DISTINCT [Energy Type]
    FROM dbo.EnergyUse
    WHERE [Energy Type] IS NOT NULL
)
SELECT
    ROW_NUMBER() OVER (ORDER BY [Energy Type]) AS EnergyTypeKey,
    [Energy Type]
FROM EnergyTypes
ORDER BY EnergyTypeKey;

/* 2. DimTime — one row per hour */
SELECT DISTINCT [Hour]
FROM dbo.EnergyUse
WHERE [Hour] IS NOT NULL
ORDER BY [Hour];

/* 3. DimDate — one row per date */
SELECT DISTINCT
    [Date],
    YEAR([Date]) AS [Year],
    MONTH([Date]) AS [Month Number],
    DATENAME(MONTH, [Date]) AS [Month Name],
    DATEPART(QUARTER, [Date]) AS [Quarter],
    DAY([Date]) AS [Day],
    DATENAME(WEEKDAY, [Date]) AS [Day Name],
    ((DATEDIFF(DAY, CONVERT(date, '19000101', 112), [Date]) % 7 + 7) % 7) + 1
        AS [Day of Week],
    CASE
        WHEN ((DATEDIFF(DAY, CONVERT(date, '19000101', 112), [Date]) % 7 + 7) % 7) + 1
             IN (6, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS [Day Type],
    CONVERT(char(7), [Date], 126) AS [Year-Month]
FROM dbo.EnergyUse
WHERE [Date] IS NOT NULL
ORDER BY [Date];

/* 4. FactEnergy — grain: Date + Hour + Energy Type */
SELECT
    [Date],
    [Hour],
    [Energy Type],
    [Consumption]
FROM dbo.EnergyUse
WHERE [Date] IS NOT NULL
  AND [Hour] IS NOT NULL
  AND [Energy Type] IS NOT NULL
  AND [Consumption] IS NOT NULL;

/* 5. FactTemperature — grain: Date + Hour */
SELECT
    [Date],
    [Hour],
    [Temperature C]
FROM dbo.Temperature
WHERE [Date] IS NOT NULL
  AND [Hour] IS NOT NULL
  AND [Temperature C] IS NOT NULL;
