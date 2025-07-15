 --Property Performance & Optimization
--1 Which types of properties generate the highest revenue potential across different neighborhoods?

SELECT
  property_type,
  neighbourhood_cleansed,
  neighbourhood_group_cleansed,
  price,
  ROUND(AVG(price * availability_30), 2) AS est_monthly_revenue
FROM airbnb.listings
WHERE price IS NOT NULL
  AND availability_30 IS NOT NULL
GROUP BY
  property_type,
  neighbourhood_cleansed,
  neighbourhood_group_cleansed,
  price
ORDER BY est_monthly_revenue DESC;

--Are Superhosts more likely to have higher occupancy or better review scores compared to non-Superhosts?
select host_is_superhost,
round(avg(1-availability_30/30.0),2) as avg_occupancy_rate,
round(avg(review_scores_rating),2) as avg_review_score,
round(avg(number_of_reviews), 1) avg_review_count
from airbnb.listings
where availability_30 is not null and review_scores_rating is not null and host_is_superhost is not null
group by 1;

--2. What availability trends do we see for high-performing listings (based on reviews or revenue)?
WITH high_performing_listings AS (
  SELECT
    id AS listing_id
  FROM `airbnb.listings`
  WHERE review_scores_rating >= 4.5
    AND number_of_reviews > 20
),

calendar_activity AS (
  SELECT
    c.listing_id,
    FORMAT_DATE('%Y-%m', c.date) AS year_month,
    COUNTIF(NOT c.available) AS days_booked,
    COUNT(*) AS total_days
  FROM airbnb.calendar1 c
  JOIN high_performing_listings hp
    ON c.listing_id = hp.listing_id
  GROUP BY c.listing_id, year_month
)

SELECT
  year_month,
  ROUND(AVG(days_booked), 2) AS avg_days_booked,
  ROUND(AVG(days_booked) / 30 * 100, 1) AS avg_est_occupancy_pct
FROM calendar_activity
GROUP BY year_month
ORDER BY year_month;



-- Step 1: Join reviews with listings to attach neighborhood information
WITH reviews_with_neighborhood AS (
  SELECT
    r.id AS review_id,
    r.date AS review_date,
    l.neighbourhood_cleansed
  FROM `airbnb.reviews` r
  JOIN `airbnb.listings` l 
    ON r.listing_id = l.id
),

-- Step 2: Count reviews per neighborhood by month
monthly_review_counts AS (
  SELECT
    neighbourhood_cleansed,
    FORMAT_DATE('%Y-%m', review_date) AS year_month,
    COUNT(*) AS review_count
  FROM reviews_with_neighborhood
  GROUP BY neighbourhood_cleansed, year_month
),

-- Step 3: Calculate average and variability in monthly review counts
neighborhood_review_stats AS (
  SELECT
    neighbourhood_cleansed,
    AVG(review_count) AS avg_monthly_reviews,
    STDDEV(review_count) AS stddev_monthly_reviews,
    COUNT(DISTINCT year_month) AS months_observed
  FROM monthly_review_counts
  GROUP BY neighbourhood_cleansed
)

--3. Which neighborhoods consistently maintain high booking activity year-round, and which are more seasonal?
SELECT
  neighbourhood_cleansed,
  ROUND(avg_monthly_reviews, 1) AS avg_monthly_reviews,
  ROUND(stddev_monthly_reviews, 1) AS variability,
  months_observed
FROM neighborhood_review_stats 
WHERE months_observed >= 10
ORDER BY avg_monthly_reviews DESC;
  
--4. Are there specific room types or property types that perform better in terms of pricing or occupancy in urban vs. suburban areas?
SELECT
  neighbourhood_cleansed,
  neighbourhood_group_cleansed,
  property_type,
  room_type,
  ROUND(AVG(price), 2) AS avg_price,
  ROUND(AVG(1 - availability_30 / 30.0), 2) AS avg_occupancy_rate,
  COUNT(*) AS listing_count
FROM airbnb.listings
WHERE price IS NOT NULL AND availability_30 IS NOT NULL
GROUP BY neighbourhood_cleansed, neighbourhood_group_cleansed,property_type, room_type
ORDER BY  avg_price DESC;


--5. What are the most common guest complaints and praises in reviews?


WITH review_sentiments AS (
  SELECT
    comments,
    CASE 
      WHEN REGEXP_CONTAINS(LOWER(comments), r'\b(clean|friendly|great|comfortable|quiet|nice|helpful)\b') THEN 'praise'
      WHEN REGEXP_CONTAINS(LOWER(comments), r'\b(dirty|noisy|small|late|broken|messy|uncomfortable|bad|rude)\b') THEN 'complaint'
      ELSE 'neutral'
    END AS sentiment
  FROM `airbnb.reviews`
),

-- Step 2: Count the number of reviews for each sentiment category
sentiment_counts AS (
  SELECT
    sentiment,
    COUNT(*) AS count
  FROM review_sentiments
  GROUP BY sentiment
)

-- Final output: Return sentiment counts
SELECT *
FROM sentiment_counts;



--6. How do review patterns (frequency, sentiment, volume) correlate with host responsiveness and acceptance rates?
WITH review_stats AS (
  SELECT
    l.id AS listing_id,
    l.host_id,
    COUNT(r.reviewer_id) AS total_reviews,
    COUNT(DISTINCT FORMAT_DATE('%Y-%m', r.date)) AS active_review_months,
    ROUND(COUNT(r.reviewer_id) * 1.0 / NULLIF(COUNT(DISTINCT FORMAT_DATE('%Y-%m', r.date)), 0), 2) AS avg_reviews_per_month,
    l.host_response_rate,
    l.host_acceptance_rate
  FROM `airbnb.listings` AS l
  LEFT JOIN `airbnb.reviews` AS r
    ON l.id = r.listing_id
  WHERE l.host_response_rate IS NOT NULL 
    AND l.host_acceptance_rate IS NOT NULL
  GROUP BY l.id, l.host_id, l.host_response_rate, l.host_acceptance_rate
)

-- Step 2: Aggregate review stats by host response and acceptance rates
SELECT
  host_response_rate,
  host_acceptance_rate,
  ROUND(AVG(total_reviews), 1) AS avg_total_reviews,
  ROUND(AVG(avg_reviews_per_month), 2) AS avg_reviews_per_month
FROM review_stats
GROUP BY host_response_rate, host_acceptance_rate
ORDER BY host_response_rate DESC, host_acceptance_rate DESC;

--Do listings with personalized or longer comments tend to receive better ratings or repeat bookings?
-- Step 1: Calculate the length of each review comment
WITH comment_lengths AS (
  SELECT
    r.listing_id,
    LENGTH(TRIM(r.comments)) AS comment_length
  FROM `airbnb.reviews` r
  WHERE r.comments IS NOT NULL
),

-- Step 2: Summarize average comment length per listing
listing_comment_summary AS (
  SELECT
    listing_id,
    ROUND(AVG(comment_length), 1) AS avg_comment_length,
    COUNT(*) AS total_reviews
  FROM comment_lengths
  GROUP BY listing_id
),

-- Step 3: Join with listing ratings
final AS (
  SELECT
    l.id AS listing_id,
    l.review_scores_rating,
    s.avg_comment_length,
    s.total_reviews
  FROM `airbnb.listings` l
  JOIN listing_comment_summary s 
    ON l.id = s.listing_id
  WHERE l.review_scores_rating IS NOT NULL
)

-- Step 4: Analyze ratings by average comment length (bucketed)
SELECT
  ROUND(avg_comment_length) AS avg_comment_length_bucket,
  ROUND(AVG(review_scores_rating), 2) AS avg_rating,
  COUNT(*) AS listing_count
FROM final
GROUP BY avg_comment_length_bucket
ORDER BY avg_comment_length_bucket;
--7. What is the relationship between price and availability — are higher-priced listings more or less likely to be available?
WITH monthly_reviews AS (
  SELECT
    r.listing_id,
    EXTRACT(YEAR FROM r.date) AS year,
    EXTRACT(MONTH FROM r.date) AS month,
    COUNT(*) AS review_volume,
   round(AVG(LENGTH(r.comments)),2) AS avg_comment_length
  FROM
    airbnb.reviews r
  JOIN
    airbnb.listings l ON r.listing_id = l.id
  WHERE
    r.comments IS NOT NULL
    AND l.price IS NOT NULL
  GROUP BY
    r.listing_id, year, month
),
listing_prices AS (
  SELECT
    id AS listing_id,
    price
  FROM
    airbnb.listings
  WHERE
    price BETWEEN 10 AND 10000
)

SELECT
  r.listing_id,
  r.year,
  r.month,
  p.price,
  r.review_volume,
  r.avg_comment_length
FROM
  monthly_reviews r
JOIN
  listing_prices p ON r.listing_id = p.listing_id
ORDER BY
  r.year, r.month, p.price;

--8. Which neighborhoods have the highest growth potential based on listing volume, price increases, and guest interest?
-- Step 1: Count number of listings by neighborhood and month
WITH listings_per_month AS (
  SELECT
    l.neighbourhood_group_cleansed,
    EXTRACT(YEAR FROM r.date) AS year,
    EXTRACT(MONTH FROM r.date) AS month,
    COUNT(DISTINCT l.id) AS listings_count
  FROM `airbnb.listings` l
  JOIN `airbnb.reviews` r ON l.id = r.listing_id
  GROUP BY 1, 2, 3
),

-- Step 2: Calculate average listing price by neighborhood and month
avg_price_per_month AS (
  SELECT
    l.neighbourhood_group_cleansed,
    EXTRACT(YEAR FROM r.date) AS year,
    EXTRACT(MONTH FROM r.date) AS month,
    AVG(l.price) AS avg_price
  FROM `airbnb.listings` l
  JOIN `airbnb.reviews` r ON l.id = r.listing_id
  GROUP BY 1, 2, 3
),

-- Step 3: Count review volume by neighborhood and month
review_volume_per_month AS (
  SELECT
    l.neighbourhood_group_cleansed,
    EXTRACT(YEAR FROM r.date) AS year,
    EXTRACT(MONTH FROM r.date) AS month,
    COUNT(r.date) AS review_count
  FROM `airbnb.listings` l
  JOIN `airbnb.reviews` r ON l.id = r.listing_id
  GROUP BY 1, 2, 3
),

-- Step 4: Combine listing count, average price, and review volume
combined AS (
  SELECT
    lpm.neighbourhood_group_cleansed,
    lpm.year,
    lpm.month,
    lpm.listings_count,
    appm.avg_price,
    rvpm.review_count
  FROM listings_per_month lpm
  JOIN avg_price_per_month appm
    ON lpm.neighbourhood_group_cleansed = appm.neighbourhood_group_cleansed
   AND lpm.year = appm.year
   AND lpm.month = appm.month
  JOIN review_volume_per_month rvpm
    ON lpm.neighbourhood_group_cleansed = rvpm.neighbourhood_group_cleansed
   AND lpm.year = rvpm.year
   AND lpm.month = rvpm.month
)

-- Step 5: Calculate growth in listings, price, and guest interest over the past 6 months
SELECT
  neighbourhood_group_cleansed,
  MAX(listings_count) - MIN(listings_count) AS listings_growth,
  ROUND(MAX(avg_price) - MIN(avg_price), 2) AS price_increase,
  MAX(review_count) - MIN(review_count) AS guest_interest_growth
FROM combined
WHERE DATE(CONCAT(year, '-', month, '-01')) >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
GROUP BY neighbourhood_group_cleansed
ORDER BY listings_growth DESC, price_increase DESC, guest_interest_growth DESC
LIMIT 10;

--Are there underserved areas (high demand but few listings) that represent opportunities for new listings?
WITH reviews_by_neighborhood AS (
  SELECT
    l.neighbourhood_group_cleansed,
    COUNT(*) AS total_reviews,  -- Fixed this line
    COUNT(DISTINCT l.id) AS listing_count,
    COUNT(*) * 1.0 / COUNT(DISTINCT l.id) AS reviews_per_listing
  FROM
    airbnb.listings l
  JOIN
    airbnb.reviews r ON l.id = r.listing_id
  WHERE
    r.date >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
  GROUP BY
    l.neighbourhood_group_cleansed
)

SELECT
  neighbourhood_group_cleansed,
  listing_count,
  total_reviews,
  ROUND(reviews_per_listing, 1) AS reviews_per_listing
FROM
  reviews_by_neighborhood
WHERE
  listing_count >= 5
ORDER BY
  reviews_per_listing DESC
LIMIT 10;


--📊 Operational Efficiency & Platform Metrics

--9. Are hosts with more listings managing them as effectively as those with fewer listings (based on reviews/availability)?
WITH host_listing_counts AS (
  SELECT
    host_id,
    COUNT(id) AS listings_count
  FROM
    `airbnb.listings`
  GROUP BY
    host_id
),

host_performance AS (
  SELECT
    l.host_id,
    COUNT(l.id) AS listings_count,
    AVG(l.availability_30) AS avg_availability_30,
    COUNT(r.listing_id) * 1.0 / COUNT(DISTINCT l.id) AS avg_reviews_per_listing
  FROM
    airbnb.listings l
  LEFT JOIN
    airbnb.reviews r ON l.id = r.listing_id
  GROUP BY
    l.host_id
),

host_grouped AS (
  SELECT
    host_id,
    listings_count,
    avg_availability_30,
    avg_reviews_per_listing,
    CASE 
      WHEN listings_count = 1 THEN '1 listing'
      WHEN listings_count BETWEEN 2 AND 5 THEN '2-5 listings'
      ELSE '6+ listings'
    END AS listing_group
  FROM
    host_performance
)

SELECT
  listing_group,
  COUNT(host_id) AS hosts,
  ROUND(AVG(avg_availability_30), 2) AS avg_availability_30,
  ROUND(AVG(avg_reviews_per_listing), 2) AS avg_reviews_per_listing
FROM
  host_grouped
GROUP BY
  listing_group
ORDER BY
  listing_group;
