USE DATABASE YELP_BI;

-- Row counts
SELECT 'REVIEWS' AS table_name, COUNT(*) AS row_count
FROM ANALYTICS.REVIEWS
UNION ALL
SELECT 'BUSINESSES', COUNT(*)
FROM ANALYTICS.BUSINESSES
UNION ALL
SELECT 'BUSINESS_CATEGORIES', COUNT(*)
FROM ANALYTICS.BRIDGE_BUSINESS_CATEGORY;

-- Duplicate business identifiers
SELECT
    business_id,
    COUNT(*) AS duplicate_count
FROM ANALYTICS.BUSINESSES
GROUP BY business_id
HAVING COUNT(*) > 1;

-- Null business identifiers
SELECT COUNT(*) AS null_business_ids
FROM ANALYTICS.BUSINESSES
WHERE business_id IS NULL;

SELECT COUNT(*) AS null_review_business_ids
FROM ANALYTICS.REVIEWS
WHERE business_id IS NULL;

-- Reviews with no matching business
SELECT COUNT(*) AS orphan_reviews
FROM ANALYTICS.REVIEWS r
LEFT JOIN ANALYTICS.BUSINESSES b
    ON r.business_id = b.business_id
WHERE b.business_id IS NULL;

-- Invalid review ratings
SELECT COUNT(*) AS invalid_review_ratings
FROM ANALYTICS.REVIEWS
WHERE review_stars NOT BETWEEN 1 AND 5
   OR review_stars IS NULL;

-- Invalid business ratings
SELECT COUNT(*) AS invalid_business_ratings
FROM ANALYTICS.BUSINESSES
WHERE business_stars NOT BETWEEN 1 AND 5
   OR business_stars IS NULL;

-- Review date range
SELECT
    MIN(review_date) AS first_review_date,
    MAX(review_date) AS last_review_date
FROM ANALYTICS.REVIEWS;

-- Sentiment distribution
SELECT
    sentiment,
    COUNT(*) AS review_count,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS review_percent
FROM ANALYTICS.REVIEWS
GROUP BY sentiment
ORDER BY review_count DESC;
