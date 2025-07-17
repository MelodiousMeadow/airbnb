# Airbnb Data Analysis Project

This portfolio project explores Airbnb listing data in New York City using **SQL**,**Python**, and **Tableau**. It covers trends in listing availability, guest reviews, prices, and neighborhood dynamics from 2009-2025.

## Table of Contents

1. [Project Goals](#project-goals)
2. [Tools Useds](#tools-used)
3. [Key Insights](#key-insights)
4. [SQL Analysis](sql-analysis)
5. [Python Analysis](python-analysis)
6. [Tableau Dashboard](tableau-dashboard)
7. [Files and Structure](#files-and-structure)

## Project Goals
- Explore availability vs. guest interest
- Uncover pricing and seasonal trends
- Analyze guest review sentiment
- Visualize insights via an interactive dashboard

## Tools Used
- **Google BigQuery** - SQL querying
- **Python (Pandas, Seaborn, CatBoost)** - data cleaning, modeling, sentiment analysis
- **Tableau** - data visualization 
- **Github** - version control and sharing

## Key Insights
- **Superhosts** have higher ratings, more bookings
- **Manhattan** listings dominate review; **Queens/Staten Island** offer better value
- **Review sentiment** is overwhelmingly positive (>98%)
- **Professional hosts** with 6+ listings earn more reveiws
- Longer review comments often correlate with higher satisfaction
- Listings priced around **100-150** are most common and attract more engagement
- **Host responsiveness** is linked to higher satisfaction and Superhost status
- Pricing is projected to remain **stable throughout the year**

## SQL Analysis

Conducted in BigQuery to explore host behavior, listing trends, and seasonal patterns.

**Sample Questions and Findings**

**1. Top-earning property types & areas:**
Entire units in **SoHo, Midtown** lead in revenue.

**2. Superhost performance:**
Higher occupancy, better reviews, more guest engagement.

**3.Review Sentiment via regex:**
98%+reviews are positive or neutral; rare complaints center on cleanliness/noise

**4. Host behavior/engagement:**
Response/acceptance >75% linked to higher review volume.

**5. Comment length & satisfaction:**
Longer reviews = better ratings.

**6. Price vs availability/engagement**
Premium listings show deepr guest interaction and lower availability.

**7. Neighborhood momentum**
**Manhattan/Brooklyn** growing fast; Queens adjusting prices swiftly.

**8. Host size and management**
Hosts with 6+ listings dominate volume with pro-level performance

## Python Analysis
Used for EDA, sentiment analysis and price prediction modeling.
**Notebook: View Python Analysis on GitHub
**1. Price Distribution**
- Listings cluster around $100-$150.
- Spikes at $100, $150, $200 suggest host anchoring.
- Few listings above $200. 

**2. Sentiment Analysis**

<img width="1415" height="743" alt="Sentiment Chart" src="https://github.com/user-attachments/assets/e07781eb-b954-4b0f-a638-e32bdfb5a130" />

- **80%+ reviews** positive
- Common praise: cleanliness, helplness.

**3. Price Prediction (CatBoost)**
- **MAE:** $411
- **R²:** 0.29
- Top predictors: room type, location, host response rate, availability

**4. Model Limitations**
- Improve acuracy with seasonality, event data, review embeddings
- Missing data (e.g. amenities) limits precision 

## 3 Tableau Dashboard
**Interactive Dashboard:** [View on Tableau Public](https://public.tableau.com/app/profile/z.w8482/viz/airbnb_17514207758520/AirBnb)

**1.Borough-Level Metrics**
- **Manhattan**: Highest price, lowest Superhost %.
- **Queens/Staten Island:** Highest satisfaciton, low price = value.

<img width="557" height="120" alt="Screenshot 2025-07-17 at 8 29 36 AM" src="https://github.com/user-attachments/assets/aa730a77-a85e-4ff2-80ab-7d715cbde3b3" />


**2. Forecasting**
- Price flat at ~177/month through Mar 2026.
- Forcast halts after Apr 2026

**3. Host Responsiveness**
- 53% of hosts respond within 1 hour; majority are Superhosts.

**4. Sentiment by Borough**
- All boroughs >35% positive reviews.
- Satisfaction not tied soely to price.

**5. Price vs. Rating**
- A scatterplot comparing boroughs by **average price vs. rating** shows:
    * **Manhattan:** Highest cost, slightly lower rating.
    * **Queens & Staten Island:** Lower prices, high satisfaction — indicating **great value.**

**6. Business Implications**
- **Budgetconscious travelers** may prefer Queens or Staten Island for great ratings at lower prices.
- **Hosts in Brooklyn or Queens** can leverage strong ratings and moderate pricing to increase market share.
- **Manhattan hosts** could improve performance by increasing responsiveness and improving guest experience.

## Key Takeaways & Actionable Steps

Airbnb listings in NYC show clear performance patterns:
- Superhosts earn more through higher ratings, faster response times, and more guest engagement.
- Entire units in Manhattan lead in revenue, but Queens/Staten Island offer better value with high satisfaction at lower prices.
- Listings priced at $100–$150 perform best; round-number pricing suggests anchoring.
- Longer, positive reviews and high host availability are tied to guest satisfaction and booking success.
- Seasonal demand peaks in spring, drops in fall—essential for pricing strategy.
**Actionable Steps:**
- **New Hosts:** Target $100–$150 range and respond quickly to guest inquiries.
- **Improve Reviews:** Focus on cleanliness and helpfulness—top drivers of positive sentiment.
- **Professional Hosts:** Track occupancy trends and optimize listings during peak seasons.
- **Optimize Listings:** Use room type, location, and availability data to improve pricing accuracy.
- **Expand Market Share:** Promote Queens/Staten Island listings to value-focused travelers.
- **Monitor Trends:** Adjust pricing/availability with seasonal forecasts to stay competitive.



```bash
airbnb/
├── sql/                         # Cleaned and documented SQL queries
├── python/                      # Python notebook and plots
├── tableau/                     # Tableau workbook and static screenshots
├── data/                        # (Optional) Source or processed data
└── README.md                    # Main documentation
