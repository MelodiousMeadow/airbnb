# Airbnb Data Analysis Project

This portfolio project explores Airbnb listing data in New York City using **SQL**,**Python**, and **Tableau**. It covers trends in listing availability, guest reviews, prices, and neighborhood dynamics.

## Table of Contents

1. [Project Goals](#project-goals)
2. [Tools Useds](#tools-used)
3. [Key Insights](#key-insights)
4. [SQL Analysis](#1-sql-analysis)
5. [Python Review Analysis](#2-python-review-analysis)
6. [Tableau Dashboard](#3-tableau-dashboard)
7. [Files and Structure](#files-and-structure)

## Project Goals
- Understand listing availability vs. guest reviews
- Identify price trends across neighborhoods
- Analyze sentiment in guest reviews
- Visualize key insights in an interactive dashboard

## Tools Used
- **Google BigQuery SQL** for querying Airbnb datasets
- **Python (Pandas, Seaborn, Matplotlib)** for sentiment and visual analysis
- **Tableau** for dashboards and data storytelling
- **Github** for collaboration

## Key Insights

## 1. SQL Analysis

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

### Example Plot: Sentiment Analysis

## 3 Tableau Dashboard

### Preview: 

## Files and Structure

```bash
airbnb/
├── sql/                         # Cleaned and documented SQL queries
├── python/                      # Python notebook and plots
├── tableau/                     # Tableau workbook and static screenshots
├── data/                        # (Optional) Source or processed data
└── README.md                    # Main documentation
