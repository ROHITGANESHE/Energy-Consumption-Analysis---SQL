<h1 align="center">🌍 Global Energy Consumption & Emission Analysis Using SQL</h1>

<h2>🧩 Overview</h2>
<p>
The <b>Global Energy Consumption & Emission Analysis</b> project is a relational SQL database solution designed to analyze worldwide energy production, consumption, emissions, GDP, and population trends.
</p>

<p>
This project demonstrates how SQL can be used to manage complex environmental and economic datasets, uncover relationships, and generate insights that support sustainable energy planning and policy decision-making.
</p>

<hr>

<h2>🗂️ Project Objectives</h2>
<ul>
<li>Build a structured database for energy, emission, GDP, and population data</li>
<li>Analyze country-wise energy consumption and production trends</li>
<li>Identify top emission-contributing countries</li>
<li>Evaluate energy efficiency using GDP and per-capita metrics</li>
<li>Perform real-world analytical queries using SQL JOINs and aggregations</li>
</ul>

<hr>

<h2>🏗️ Database Design</h2>

<h3>🧱 Entities</h3>
<ul>
<li><b>Country</b> – List of countries with unique identifiers</li>
<li><b>Consumption</b> – Energy consumption by country and energy type</li>
<li><b>Production</b> – Energy production by country and energy type</li>
<li><b>Emission</b> – CO₂ emissions and per-capita emission values</li>
<li><b>GDP</b> – Economic output by country and year</li>
<li><b>Population</b> – Population statistics for per-capita analysis</li>
</ul>

<hr>

<h2>🧮 SQL Operations</h2>

<h3>✅ Tables Created</h3>
<pre>
CREATE TABLE country (...);
CREATE TABLE consumption (...);
CREATE TABLE production (...);
CREATE TABLE emission_3 (...);
CREATE TABLE gdp_3 (...);
CREATE TABLE population (...);
</pre>

<hr>

<h2>🔗 Entity Relationship Diagram (ERD)</h2>
<pre>
Country 1 ——— N Consumption
Country 1 ——— N Production
Country 1 ——— N Emission
Country 1 ——— N GDP
Country 1 ——— N Population
</pre>

<hr>

<h2>📊 Queries and Results</h2>

<table border="1" cellpadding="8">
<tr>
<th>#</th>
<th>Query Objective</th>
<th>Description</th>
<th>Example Insight</th>
</tr>

<tr><td>1</td><td>Total Emissions</td><td>Retrieve country-wise emissions for latest year</td><td>China & USA highest emitters</td></tr>
<tr><td>2</td><td>Top GDP Countries</td><td>Identify top economic contributors</td><td>USA, China, India</td></tr>
<tr><td>3</td><td>Production vs Consumption</td><td>Compare production and consumption levels</td><td>Exporters vs importers identified</td></tr>
<tr><td>4</td><td>Net Energy Balance</td><td>Detect energy surplus/deficit countries</td><td>Oil exporters show surplus</td></tr>
<tr><td>5</td><td>Per Capita Emission</td><td>Analyze environmental impact per citizen</td><td>Developed nations higher per capita</td></tr>
<tr><td>6</td><td>Emission-to-GDP Ratio</td><td>Evaluate sustainability efficiency</td><td>High GDP with low emissions = efficient</td></tr>
</table>

<hr>

<h2>💡 Key Insights</h2>
<ul>
<li>🌍 <b>Emission Trends:</b> Clear identification of major global polluters</li>
<li>⚡ <b>Energy Balance:</b> Insight into energy-importing and exporting countries</li>
<li>📈 <b>Economic Impact:</b> GDP strongly correlates with energy consumption</li>
<li>👥 <b>Per Capita Metrics:</b> Developed countries show higher per-person energy usage</li>
<li>📊 <b>Sustainability Analysis:</b> Emission-to-GDP ratio highlights efficiency leaders</li>
</ul>

<hr>

<h2>⚙️ Tools & Technologies</h2>
<ul>
<li><b>Database:</b> MySQL / PostgreSQL</li>
<li><b>Query Language:</b> SQL</li>
<li><b>Design:</b> ER Modeling & Normalization</li>
<li><b>Visualization:</b> PowerPoint / Power BI</li>
</ul>

<hr>

<h2>🚧 Challenges Faced</h2>
<ul>
<li>Handling multiple large datasets across years</li>
<li>Writing complex JOIN queries for cross-domain analysis</li>
<li>Ensuring data consistency and normalization</li>
<li>Performing per-capita and ratio-based calculations</li>
</ul>

<hr>

<h2>🏁 Conclusion</h2>
<p>
This project provided hands-on experience in relational database design, SQL query optimization, and environmental data analytics.
It highlights how structured SQL databases can help policymakers and analysts understand energy demand, economic growth, and sustainability trade-offs.
</p>

<hr>

<h2>👨‍💻 Author</h2>
<p>
<b>Rohit Ganeshe</b><br>
🔗 <a href="https://www.linkedin.com/in/rohit-ganeshe-8a7041237">LinkedIn Profile</a>
</p>

<hr>

<h2>⭐ Repo Description (Short)</h2>
<p>
👉 SQL project analyzing global energy consumption, production, emissions, GDP, and population trends with advanced analytical queries.
</p>

