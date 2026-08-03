USE DATABASE YELP_BI;

CREATE OR REPLACE VIEW REPORTING.VW_REVIEWS AS
SELECT
    business_id,
    review_date,
    user_id,
    review_stars,
    review_text,
    review_length,
    sentiment AS sentiments
FROM ANALYTICS.REVIEWS;

CREATE OR REPLACE VIEW REPORTING.VW_BUSINESSES AS
SELECT
    business_id,
    name,
    city,
    state,
    source_review_count AS review_count,
    business_stars AS stars,
    categories
FROM ANALYTICS.BUSINESSES;

CREATE OR REPLACE VIEW REPORTING.VW_BUSINESS_CATEGORIES AS
SELECT
    business_id,
    category
FROM ANALYTICS.BRIDGE_BUSINESS_CATEGORY;

CREATE OR REPLACE VIEW REPORTING.VW_BUSINESS_PERFORMANCE AS
SELECT
    b.business_id,
    b.name,
    b.city,
    b.state,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.review_stars), 2) AS average_review_rating,
    COUNT_IF(r.review_stars = 5) AS five_star_reviews,
    ROUND(100 * COUNT_IF(r.review_stars = 5) / NULLIF(COUNT(*), 0), 2) AS five_star_percent,
    COUNT_IF(r.sentiment = 'Positive') AS positive_reviews,
    ROUND(100 * COUNT_IF(r.sentiment = 'Positive') / NULLIF(COUNT(*), 0), 2) AS positive_sentiment_percent
FROM ANALYTICS.BUSINESSES b
JOIN ANALYTICS.REVIEWS r
    ON b.business_id = r.business_id
GROUP BY
    b.business_id,
    b.name,
    b.city,
    b.state;

CREATE OR REPLACE VIEW REPORTING.VW_GEOGRAPHIC_PERFORMANCE AS
WITH business_summary AS (
    SELECT
        state,
        city,
        COUNT(DISTINCT business_id) AS business_count,
        ROUND(AVG(business_stars), 2) AS average_business_rating
    FROM ANALYTICS.BUSINESSES
    GROUP BY state, city
),
review_summary AS (
    SELECT
        b.state,
        b.city,
        COUNT(*) AS total_reviews
    FROM ANALYTICS.REVIEWS r
    JOIN ANALYTICS.BUSINESSES b
        ON r.business_id = b.business_id
    GROUP BY b.state, b.city
)
SELECT
    b.state,
    b.city,
    b.business_count,
    COALESCE(r.total_reviews, 0) AS total_reviews,
    b.average_business_rating,
    ROUND(COALESCE(r.total_reviews, 0) / NULLIF(b.business_count, 0), 2) AS reviews_per_business
FROM business_summary b
LEFT JOIN review_summary r
    ON b.state = r.state
   AND b.city = r.city;
