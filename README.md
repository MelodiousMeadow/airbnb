# Airbnb Data Analysis Project

This portfolio project explores Airbnb listing data in New York City using **SQL**,**Python**, and **Tableau**. It covers trends in listing availability, guest reviews, prices, and neighborhood dynamics.

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
- **Google BigQuery SQL** for querying Airbnb datasets
- **Python (Pandas, Seaborn, Matplotlib)** for sentiment and visual analysis
- **Tableau** for dashboards and data storytelling
- **Github** for collaboration

## Key Insights

## 1 SQL Analysis

This section focuses on the SQL-based exploratory analysis that powered deeper understanding of Airbnb performance across New York City. Queries were executed using **BigQuery SQL** and laid the groundwork for data visualization and further modeling in Tableau and Python.

**1. Which property types and neighborhoods generate the most revenue?**

- Used AVG(price*availability_30) with grouping and filtering.
- 💡**Insight:** Entire unites in **Manhattan** (esp SoHo, Midtown) dominate eranings. Luxury and boutique listings significantly outperform basic accommodations.

**2.Do Superhosts outperform non-Superhosts?**
- Aggregated availability_30, review_scores_rating, and number_of_reviews by host_is_superhost.
- 💡**Insight:** Superhosts have **higher occupancy, better ratings,** and **more reviews.**

**3. What are the seasonal availability trends for high-performing listings?**
- Built a **CTE** to isolate high-rated listings; joined with calendar data to calculate monthly occupancy
- Peak in May 2025: 18.4 days booked (61.3% occupancy)
- Decline through Oct 2025 to 34.1%, reflecting seasonal slowdown
- Slight rebound Nov–Dec 2025 (~40% occupancy)
- 🔮 Trends after July 2025 are predictive and show continued seasonal dips through early 2026.

**4. What are the most common review sentiments?**
- Applied **regex-based text classfication** usining REGEX_CONTAINS on review comments.
- **💡 Insight:** Over 98% of reviews are positive or neutral; complaints are rare but focus on cleanliness and noise.

**5. Do hosts with higher response/acceptance rates get more engagement?**
- Joined listings and reviews; used COUNT, AVG, and GROUP BY on host behavior metrics.
- **💡 Insight:** Hosts with **>75% response/acceptance rates** see significantly higher review frequency.

**6. Does comment length correlate with better ratings?**
- Calculated AVG(LENGTH(comments)) per listing and bucketed by length.
- **💡 Insight: Longer, more detailed comments** often align with higher guest satisfaction (ratings).

**7. Is there a relationship between listing price and availability or engagement?**
- Combined review volume, price data, and comment length.
**💡 Insight:Premium listings** tend to have longer comments, suggesting stronger engagement; lower availability often reflects higher booking.

**8. Which neighborhoods are growing fastest?**
- Used CTEs and time-based grouping (EXTRACT(YEAR/MONTH)), calculated changes in volume, price, and review counts over 6 months.
- **💡 Insight: Manhattan and Brooklyn** show the most momentum; **Queens** is adjusting prices faster than guest demand.

**9. Do hosts with more listings manage them better?**
- Grouped hosts by listing count and calculated review/availability stats.
- **💡 Insight:** Hosts with **6+ listings** dominate review volume but have lower availability—indicating **strong performance and professional management.**


## 2 Python Review Analysis

This project uses **Python** (Pandas, scikit-learn, CatBoost, visualization libraries) to analyze NYC Airbnb market patterns and predict listing prices.

**1. Listing Price Distributrion and Market Norms**
- Most listings priced between $100 and $150, a central pricing 'sweet spot.'
- Sharp drop-off in listings above $200 indicating fewer luxury rentals.
- Pricing spikes at round numbers ($100, $150, $200) suggest host anchoring behavior.
- **Implication:** New hosts may maximize visibility/pricing success by targeting this mid-range band.

**2. Guest Review Sentiment**


<img width="1415" height="743" alt="Screenshot 2025-07-17 at 8 26 45 AM" src="https://github.com/user-attachments/assets/e07781eb-b954-4b0f-a638-e32bdfb5a130" />


- Over **80%** of reviews are positive, especially in **Brooklyn and Staten Island.**
- Common praised features include cleanliness and helpfulness (see word cloud visualization).

**3. Price Prediction Model (CatBoost Regression)**
- Mean Absolute Error (MAE): $411 — average price prediction error.
- R² Score: **0.29** — model explains ~29% of price variance.
- Key features influencing price include: room type, location, host response rate, availability, and neighborhood.
- Feature importance highlights critical variables for pricing decisions.

**4. Model Limitations & Improvement Areas**
- Moderate predictive power indicates room for enhancement.
- Suggested improvements: incorporate seasonality, events data, and review text embeddings.
- Data completeness (e.g., amenities, host info) impacts model accuracy.

## 3 Tableau Dashboard

**1.Borough-Level Metrics**
**Manhattan** stands out with a significantly higher price, despite having the **lowest Superhost percentage.** In contrast, **Queens and Staten Island** offer high satisfaction (4.8 rating) at much lower costs.

<img width="557" height="120" alt="Screenshot 2025-07-17 at 8 29 36 AM" src="https://github.com/user-attachments/assets/aa730a77-a85e-4ff2-80ab-7d715cbde3b3" />


**2. Forecast Trends**
- The **Average Monthly Price** is projected to stay flat at $177 through March 2026.
- Forecasts appear paused after April 2026.

**3. Host Responsiveness**
- **11,665 listings (53%)** respond within an hour, of which **3,965 are Superhosts.**
- Higher responsiveness correlates with Superhost status and likely guest satisfaction.

**4. Customer Sentiment by Borough**
- Most boroughs show over 35% positive reviews, with Queens and Staten Island edging slightly higher.
- Sentiment is generally positive across all areas, suggesting satisfaction is not solely price-dependent.

**5. Cost vs. Satisfaction**
- A scatterplot comparing boroughs by **average price vs. rating** shows:
    * **Manhattan:** Highest cost, slightly lower rating.
    * **Queens & Staten Island:** Lower prices, high satisfaction — indicating **great value.**

**6. Business Implications**
- **Budget-conscious travelers** may prefer Queens or Staten Island for great ratings at lower prices.
- **Hosts in Brooklyn or Queens** can leverage strong ratings and moderate pricing to increase market share.
- **Manhattan hosts** could improve performance by increasing responsiveness and improving guest experience.



### Preview: 

## Files and Structure

```bash
airbnb/
├── sql/                         # Cleaned and documented SQL queries
├── python/                      # Python notebook and plots
├── tableau/                     # Tableau workbook and static screenshots
├── data/                        # (Optional) Source or processed data
└── README.md                    # Main documentation
