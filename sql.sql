create database Energydb;
use Energydb;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- 3. population table 
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);
SELECT * FROM COUNTRY;
SELECT * FROM EMISSION_3;
SELECT * FROM POPULATION;
SELECT * FROM PRODUCTION;
SELECT * FROM GDP_3;
SELECT * FROM CONSUMPTION;
use Energydb;
-- General & Comparative Analysis
-- 1. What is the total emission per country for the most recent year available?
SELECT country, 
SuM(emission) AS total_emission
FROM emission_3
WHERE year = (SELECT MAX(year) FROM emission_3)
GROUP BY country
ORDER BY total_emission DESC;

-- 2.What are the top 5 countries by GDP in the most recent year?
SELECT Country, Value AS GDP
FROM gdp_3
WHERE year = (SELECT MAX(year) FROM gdp_3)
ORDER BY GDP DESC
LIMIT 5;

-- 3.Compare energy production and consumption by country and year.
SELECT p.country,p.year,
SUM(p.production) AS total_production,
SUM(c.consumption) AS total_consumption,
(SUM(p.production) - SUM(c.consumption)) AS net_balance,
CASE WHEN SUM(p.production) > SUM(c.consumption) THEN 'Net Exporter'
WHEN SUM(p.production) < SUM(c.consumption) THEN 'Net Importer'
ELSE 'Balanced' END AS trade_status FROM production p JOIN consumption c 
ON p.country = c.country AND p.year = c.year AND p.energy = c.energy
GROUP BY p.country, p.year
ORDER BY p.year DESC, ABS(SUM(p.production) - SUM(c.consumption)) DESC;

-- 4. Which energy types contribute most to emissions across all countries?
SELECT energy_type,
SUM(emission) AS total_emissions
FROM emission_3
GROUP BY energy_type
ORDER BY total_emissions DESC;

-- Trend Analysis Over Time
-- 5. How have global emissions changed year over year?

WITH yearly_totals AS (SELECT year,SUM(emission) AS total_emissions FROM emission_3
GROUP BY year),
emissions_yoy AS (SELECT year,total_emissions,LAG(total_emissions) OVER (ORDER BY year) AS previous_year_emissions
FROM yearly_totals) SELECT year,total_emissions,previous_year_emissions,
(total_emissions - previous_year_emissions) AS yoy_change,
ROUND(100.0 * (total_emissions - previous_year_emissions) / NULLIF(previous_year_emissions, 0), 2) AS yoy_percent_change
FROM emissions_yoy
ORDER BY year ASC limit 3 offset 1;

-- 6. What is the trend in GDP for each country over the given years?
WITH gdp_by_country_year AS (SELECT Country,year,SUM(Value) AS total_gdp
FROM gdp_3 GROUP BY Country, year),
gdp_with_yoy AS (SELECT Country,year,total_gdp,
LAG(total_gdp) OVER (PARTITION BY Country ORDER BY year) AS prev_year_gdp 
FROM gdp_by_country_year)
SELECT Country,year,total_gdp,prev_year_gdp,
(total_gdp - prev_year_gdp) AS absolute_change,
ROUND(100.0 * (total_gdp - prev_year_gdp) / NULLIF(prev_year_gdp, 0),2) AS percent_change
FROM gdp_with_yoy
ORDER BY Country, year;

-- 7. How has population growth affected total emissions in each country?
WITH population_data AS (SELECT countries AS country,year,SUM(Value) AS total_population 
FROM population
GROUP BY countries, year),
emission_data AS (
SELECT country,year,SUM(emission) AS total_emissions FROM emission_3 GROUP BY country, year),
emissions_vs_population AS (SELECT e.country,e.year,total_emissions,total_population,
ROUND(total_emissions / NULLIF(total_population, 0), 4) AS emissions_per_capita
FROM emission_data e
JOIN population_data p ON e.country = p.country AND e.year = p.year)
SELECT country,year,total_emissions,total_population,emissions_per_capita
FROM emissions_vs_population ORDER BY country, year;

-- 8. Has energy consumption increased or decreased over the years for major economies?
SELECT country,year,SUM(consumption) AS total_consumption
FROM consumption
WHERE country IN ('United States', 'China', 'India', 
'Germany', 'Japan', 'Russia', 'Brazil') -- Add/remove countries as needed
GROUP BY country, year ORDER BY country, year;

-- 9.What is the average yearly change in emissions per capita for each country?
WITH per_capita_yoy AS (SELECT country,year,per_capita_emission,
LAG(per_capita_emission) OVER (PARTITION BY country ORDER BY year) AS prev_year_emission
FROM emission_3),yearly_change AS (SELECT country,
year,(per_capita_emission - prev_year_emission) AS change_per_year
FROM per_capita_yoy WHERE prev_year_emission IS NOT NULL)
SELECT country,ROUND(AVG(change_per_year), 4) AS avg_yearly_change_per_capita
FROM yearly_change
GROUP BY country ORDER BY avg_yearly_change_per_capita DESC;

-- Ratio & Per Capita Analysis
-- 10. What is the emission-to-GDP ratio for each country by year?

WITH total_emissions AS (SELECT country,
year,SUM(emission) AS total_emission FROM emission_3
GROUP BY country, year),gdp_by_country_year AS (SELECT Country AS country,
year,SUM(Value) AS total_gdp FROM gdp_3
GROUP BY Country, year)SELECT e.country,
e.year,total_emission,total_gdp,
ROUND(total_emission / NULLIF(total_gdp, 0), 6) AS emission_to_gdp_ratio
FROM total_emissions e
JOIN gdp_by_country_year g ON e.country = g.country AND e.year = g.year
ORDER BY e.country, e.year;

-- 11. What is the energy consumption per capita for each country over the last decade?
WITH recent_years AS (
SELECT DISTINCT year FROM consumption ORDER BY year DESC LIMIT 4),
consumption_by_country AS (
SELECT country,year,SUM(consumption) AS total_consumption
FROM consumption WHERE year IN (SELECT year FROM recent_years)
GROUP BY country, year),
population_by_country AS (SELECT countries AS country,
year,SUM(Value) AS total_population FROM population WHERE year IN (SELECT year FROM recent_years)GROUP BY countries, year)
SELECT c.country,c.year,total_consumption,total_population,
ROUND(total_consumption / NULLIF(total_population, 0), 4) AS consumption_per_capita
FROM consumption_by_country c JOIN population_by_country p ON c.country = p.country AND c.year = p.year
ORDER BY c.country, c.year;

-- 12. How does energy production per capita vary across countries?
WITH production_totals AS ( SELECT country,year,
SUM(production) AS total_production FROM production
GROUP BY country, year),population_totals AS (
SELECT countries AS country,year,SUM(Value) AS total_population FROM population
GROUP BY countries, year)SELECT p.country,p.year,total_production,total_population,
ROUND(total_production / NULLIF(total_population, 0), 4) AS production_per_capita
FROM production_totals p
JOIN population_totals pop ON p.country = pop.country AND p.year = pop.year ORDER BY p.country, p.year;

-- 13. Which countries have the highest energy consumption relative to GDP? 
WITH total_consumption AS (SELECT country,year,
SUM(consumption) AS total_consumption FROM onsumption GROUP BY country, year),
total_gdp AS (SELECT Country AS country,year,
UM(Value) AS total_gdp FROM gdp_3 GROUP BY Country, year)
SELECT c.country,c.year,total_consumption,total_gdp,
ROUND(total_consumption / NULLIF(total_gdp, 0), 6) AS consumption_to_gdp_ratio
FROM total_consumption c
JOIN total_gdp g ON c.country = g.country AND c.year = g.year 
ORDER BY consumption_to_gdp_ratio DESC;

-- 14 What is the correlation between GDP growth and energy production growth? 
WITH gdp_totals AS (SELECT Country AS country,year,
SUM(Value) AS gdp FROM gdp_3 GROUP BY Country, year),
gdp_growth AS (SELECT country,year,gdp,
LAG(gdp) OVER (PARTITION BY country ORDER BY year) AS prev_gdp,
ROUND((gdp - LAG(gdp) OVER (PARTITION BY country ORDER BY year))
/ NULLIF(LAG(gdp) OVER (PARTITION BY country ORDER BY year), 0), 4) AS gdp_growth
FROM gdp_totals),production_totals AS (SELECT country,year,
SUM(production) AS total_production FROM production
GROUP BY country, year),production_growth AS (SELECT country,
year,total_production,
LAG(total_production) OVER (PARTITION BY country ORDER BY year) AS prev_production,
ROUND((total_production - LAG(total_production) OVER (PARTITION BY country ORDER BY year))
/ NULLIF(LAG(total_production) OVER (PARTITION BY country ORDER BY year), 0), 4) AS production_growth
FROM production_totals)SELECT g.country,g.year,g.gdp,g.gdp_growth,p.total_production,p.production_growth 
FROM gdp_growth g
JOIN production_growth p ON g.country = p.country AND g.year = p.year
ORDER BY g.country, g.year;

--  Global Comparisons
-- 15. What are the top 10 countries by population and how do their emissions compare?
WITH population_totals AS (
SELECT countries AS country,year,SUM(Value) AS total_population
FROM population
GROUP BY countries, year),emission_totals AS (SELECT country,year,
SUM(emission) AS total_emissions FROM emission_3 GROUP BY country, year),
joined_data AS (SELECT p.country,p.year,p.total_population,e.total_emissions,
ROUND(e.total_emissions / NULLIF(p.total_population, 0), 4) AS per_capita_emissions
FROM population_totals p JOIN emission_totals e ON p.country = e.country AND p.year = e.year)
SELECT country,year,total_population,total_emissions,per_capita_emissions
FROM joined_data
WHERE year = (SELECT MAX(year) FROM population)  -- Latest available year
ORDER BY total_population DESC LIMIT 10;

-- 16. Which countries have improved (reduced) their per capita emissions the most over the last decade?
SELECT early.country,
ROUND(early.per_capita_emission - recent.per_capita_emission, 2) AS reduction,
early.per_capita_emission AS emission_2020,
recent.per_capita_emission AS emission_2024
FROM (SELECT country, per_capita_emission FROM emission_3
WHERE year = 2020) AS early
JOIN (SELECT country, per_capita_emission
FROM emission_3 WHERE year = 2024)AS recent
ON early.country = recent.country
WHERE early.per_capita_emission > recent.per_capita_emission
ORDER BY reduction DESC;

 -- 17. What is the global share (%) of emissions by country?
SELECT country,
ROUND(SUM(emission) * 100.0 / (SELECT SUM(emission) FROM emission_3), 2) 
AS global_share_percentage
FROM emission_3
GROUP BY country
ORDER BY global_share_percentage DESC;

-- 18. What is the global average GDP, emission, and population by year?
SELECT g.year,
ROUND(AVG(g.Value), 2) AS avg_gdp,
(SELECT SUM(e.emission)  
FROM emission_3 e WHERE e.year = g.year) AS total_emission,
ROUND(AVG(p.Value), 0) AS avg_population
FROM gdp_3 g JOIN population p ON g.Country = p.countries AND g.year = p.year
GROUP BY g.year
ORDER BY g.year;




