📚 Global Energy Consumption & Emission Analysis Using SQL
🧩 Overview

The Global Energy Consumption & Emission Analysis project is a relational SQL database solution designed to analyze worldwide energy production, consumption, emissions, GDP, and population trends.

This project demonstrates how SQL can be used to manage complex environmental and economic datasets, uncover relationships, and generate insights that support sustainable energy planning and policy decision-making.

🗂️ Project Objectives

Build a structured database for energy, emission, GDP, and population data
Analyze country-wise energy consumption and production trends
Identify top emission-contributing countries
Evaluate energy efficiency using GDP and per-capita metrics
Perform real-world analytical queries using SQL JOINs and aggregations

🏗️ Database Design
🧱 Entities

Country – List of countries with unique identifiers
Consumption – Energy consumption by country and energy type
Production – Energy production by country and energy type
Emission – CO₂ emissions and per-capita emission values
GDP – Economic output by country and year
Population – Population statistics for per-capita analysis

🧮 SQL Operations
✅ Tables Created
CREATE TABLE country (...);
CREATE TABLE consumption (...);
CREATE TABLE production (...);
CREATE TABLE emission_3 (...);
CREATE TABLE gdp_3 (...);
CREATE TABLE population (...);

🔗 Entity Relationship Diagram (ERD)
Country 1 ——— N Consumption
Country 1 ——— N Production
Country 1 ——— N Emission
Country 1 ——— N GDP
Country 1 ——— N Population

📊 Queries and Results
#	Query Objective	Description	Example Insight
1	Total Emissions	Retrieve country-wise emissions for latest year	China & USA highest emitters
2	Top GDP Countries	Identify top economic contributors	USA, China, India
3	Production vs Consumption	Compare production and consumption levels	Exporters vs importers identified
4	Net Energy Balance	Detect energy surplus/deficit countries	Oil exporters show surplus
5	Per Capita Emission	Analyze environmental impact per citizen	Developed nations higher per capita
6	Emission-to-GDP Ratio	Evaluate sustainability efficiency	High GDP with low emissions = efficient
💡 Key Insights

🌍 Emission Trends: Clear identification of major global polluters
⚡ Energy Balance: Insight into energy-importing and exporting countries
📈 Economic Impact: GDP strongly correlates with energy consumption
👥 Per Capita Metrics: Developed countries show higher per-person energy usage
📊 Sustainability Analysis: Emission-to-GDP ratio highlights efficiency leaders

⚙️ Tools & Technologies

Database: MySQL / PostgreSQL

Query Language: SQL

Design: ER Modeling & Normalization

Visualization: PowerPoint / Power BI

🚧 Challenges Faced

Handling multiple large datasets across years

Writing complex JOIN queries for cross-domain analysis

Ensuring data consistency and normalization

Performing per-capita and ratio-based calculations

🏁 Conclusion

This project provided hands-on experience in relational database design, SQL query optimization, and environmental data analytics.
It highlights how structured SQL databases can help policymakers and analysts understand energy demand, economic growth, and sustainability trade-offs.


⭐ Repo Description (Short)
👉 SQL project analyzing global energy consumption, production, emissions, GDP, and population trends with advanced analytical queries.
