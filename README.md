# Airbnb Data Analysis Project

This portfolio project explores Airbnb listing data in New York City (2009-2025) using **SQL**,**Python**, and **Tableau**. It uncovers trends in listing availability, guest reviews, pricing, and neighborhood dynamics to inform host strategy and improve guest experience.

## Table of Contents

1. [Project Goals](#project-goals)
2.  [Tools Useds](#tools-used)
3. [Key Insights](#key-insights)
4.  [SQL Analysis](sql-analysis)
5.  [Python Analysis](python-analysis)
6. [Tableau Dashboard](tableau-dashboard)
7. [Takeaways & Actionable Steps](takeaways-&-actionable-steps)
8. [Files & Strucutre](files-&-structure)

## Project Goals
- Explore availability vs. guest interest
- Uncover pricing and seasonal trends
- Analyze sentiment in guest reviews
- Visualize insights via an interactive dashboard

## Tools Used
- **Google BigQuery** - SQL querying and aggregation
- **Python (Pandas, Seaborn, CatBoost)** - data cleaning, modeling, sentiment analysis
- **Tableau** - data visualization 
- **Github** - version control and sharing

## Key Insights
- **Superhosts** have higher ratings, better engagement, more bookings
- **Manhattan** earn most; **Queens/Staten Island** offer better value
- **98%+ of reviews** are positive or neutral
- **Professional hosts** with 6+ listings earn more reveiws
- Longer review comments often correlate with higher satisfaction
- Listings priced around **100-150** are most common and attract more engagement
- **Fast host response times** boost satisfaciton and Superhost status
- Pricing is projected to remain **stable throughout the year**

## SQL Analysis 
📎 [View SQL file](airbnb.sql) 

SQL queries in BigQuery explored host behavior, review patterns, and revenue across property types and neighborhoods.

**Sample Findings**


**Key Insights**

&nbsp;&nbsp;&nbsp;**1. Top-earning property types & areas:** Entire units in SoHo, Midtown earn the most

&nbsp;&nbsp;&nbsp;**2. Superhost performance:** Higher occupancy and more positive reviews

&nbsp;&nbsp;&nbsp;**3.Sentiment via Regex:** 98%+reviews are positive or neutral

&nbsp;&nbsp;&nbsp;**4. Host Engagement:** Response/acceptance >75% = more reviews

&nbsp;&nbsp;&nbsp;**5. Comment Length Matters:** Longer reviews = higher satisfaction

&nbsp;&nbsp;&nbsp;**6. Premium Listings:** Lower availability, more guest engagement

&nbsp;&nbsp;&nbsp;**7. Neighborhood Growth** **Manhattan/Brooklyn** growing fast; Queens adjusting prices

&nbsp;&nbsp;&nbsp;**8. Host size and management** Hosts with 6+ listings show strong performance

## Python Analysis
📎 [View Python Analysis on GitHub](airbnb.ipynb)

Used for exploratory analysis, sentiment classification, and price prediction.

### Highlights 

**1. Price Distribution:** Most listings fall between $100-$150; pricing spikes at $100, $150, $200 suggest anchoring

**2. Sentiment Analysis:**

<p align="center">
  <img width="1415" height="743" alt="Sentiment Chart" src="https://github.com/user-attachments/assets/e07781eb-b954-4b0f-a638-e32bdfb5a130" />
</p>


- **80%+ reviews** are positive
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

## Files and Structure

```bash
airbnb/
├── sql/                         # Cleaned and documented SQL queries
├── python/                      # Python notebook and plots
├── tableau/                     # Tableau workbook and static screenshots
├── data/                        # (Optional) Source or processed data
└── README.md                    # Main documentation
