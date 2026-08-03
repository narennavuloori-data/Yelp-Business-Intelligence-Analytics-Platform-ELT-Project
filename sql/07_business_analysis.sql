USE DATABASE YELP_BI;

-- 1. Number of businesses in each category
SELECT
    category,
    COUNT(DISTINCT business_id) AS number_of_businesses
FROM ANALYTICS.BRIDGE_BUSINESS_CATEGORY
GROUP BY category
ORDER BY number_of_businesses DESC;

-- 2. Top 10 users who reviewed the most restaurant businesses
SELECT
    r.user_id,
    COUNT(DISTINCT r.business_id) AS businesses_reviewed
FROM ANALYTICS.REVIEWS r
JOIN ANALYTICS.BRIDGE_BUSINESS_CATEGORY c
    ON r.business_id = c.business_id
WHERE LOWER(c.category) = 'restaurants'
GROUP BY r.user_id
ORDER BY businesses_reviewed DESC
LIMIT 10;

-- 3. Most reviewed categories
SELECT
    c.category,
    COUNT(*) AS total_reviews
FROM ANALYTICS.BRIDGE_BUSINESS_CATEGORY c
JOIN ANALYTICS.REVIEWS r
    ON c.business_id = r.business_id
GROUP BY c.category
ORDER BY total_reviews DESC;

-- 4. Five most recent reviews for every business
WITH ranked_reviews AS (
    SELECT
        r.business_id,
        b.name,
        r.user_id,
        r.review_date,
        r.review_stars,
        r.sentiment,
        r.review_text,
        ROW_NUMBER() OVER (
            PARTITION BY r.business_id
            ORDER BY r.review_date DESC
        ) AS review_rank
    FROM ANALYTICS.REVIEWS r
    JOIN ANALYTICS.BUSINESSES b
        ON r.business_id = b.business_id
)
SELECT *
FROM ranked_reviews
WHERE review_rank <= 5
ORDER BY business_id, review_rank;

-- 5. Review activity by year and month
SELECT
    DATE_TRUNC('MONTH', review_date) AS review_month,
    COUNT(*) AS number_of_reviews
FROM ANALYTICS.REVIEWS
GROUP BY review_month
ORDER BY number_of_reviews DESC;

-- 6. Five-star review percentage for every business
SELECT
    b.business_id,
    b.name,
    COUNT(*) AS total_reviews,
    COUNT_IF(r.review_stars = 5) AS five_star_reviews,
    ROUND(
        100 * COUNT_IF(r.review_stars = 5) / NULLIF(COUNT(*), 0),
        2
    ) AS five_star_percent
FROM ANALYTICS.REVIEWS r
JOIN ANALYTICS.BUSINESSES b
    ON r.business_id = b.business_id
GROUP BY b.business_id, b.name
ORDER BY five_star_percent DESC;

-- 7. Top five reviewed businesses in each city
WITH business_reviews AS (
    SELECT
        b.business_id,
        b.name,
        b.city,
        b.state,
        COUNT(*) AS total_reviews
    FROM ANALYTICS.REVIEWS r
    JOIN ANALYTICS.BUSINESSES b
        ON r.business_id = b.business_id
    GROUP BY b.business_id, b.name, b.city, b.state
),
ranked_businesses AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY city, state
            ORDER BY total_reviews DESC
        ) AS city_rank
    FROM business_reviews
)
SELECT *
FROM ranked_businesses
WHERE city_rank <= 5
ORDER BY state, city, city_rank;

-- 8. Average rating for businesses with at least 100 reviews
SELECT
    b.business_id,
    b.name,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.review_stars), 2) AS average_review_rating
FROM ANALYTICS.REVIEWS r
JOIN ANALYTICS.BUSINESSES b
    ON r.business_id = b.business_id
GROUP BY b.business_id, b.name
HAVING COUNT(*) >= 100
ORDER BY average_review_rating DESC, total_reviews DESC;

-- 9. Top 10 businesses by positive review count
SELECT
    b.business_id,
    b.name,
    COUNT(*) AS positive_review_count
FROM ANALYTICS.REVIEWS r
JOIN ANALYTICS.BUSINESSES b
    ON r.business_id = b.business_id
WHERE r.sentiment = 'Positive'
GROUP BY b.business_id, b.name
ORDER BY positive_review_count DESC
LIMIT 10;
