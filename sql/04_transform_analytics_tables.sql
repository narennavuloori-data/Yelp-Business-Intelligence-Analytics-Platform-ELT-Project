USE DATABASE YELP_BI;

CREATE OR REPLACE TABLE ANALYTICS.REVIEWS AS
SELECT
    review_record:business_id::STRING AS business_id,
    review_record:date::DATE AS review_date,
    review_record:user_id::STRING AS user_id,
    review_record:stars::NUMBER(2,1) AS review_stars,
    review_record:text::STRING AS review_text,
    LENGTH(review_record:text::STRING) AS review_length,
    ANALYTICS.ANALYZE_SENTIMENT(review_record:text::STRING) AS sentiment
FROM RAW.YELP_REVIEWS;

CREATE OR REPLACE TABLE ANALYTICS.BUSINESSES AS
SELECT
    business_record:business_id::STRING AS business_id,
    business_record:name::STRING AS name,
    business_record:city::STRING AS city,
    business_record:state::STRING AS state,
    business_record:review_count::NUMBER AS source_review_count,
    business_record:stars::NUMBER(2,1) AS business_stars,
    business_record:categories::STRING AS categories
FROM RAW.YELP_BUSINESSES;

CREATE OR REPLACE TABLE ANALYTICS.BRIDGE_BUSINESS_CATEGORY AS
SELECT DISTINCT
    b.business_id,
    TRIM(category.value::STRING) AS category
FROM ANALYTICS.BUSINESSES b,
LATERAL SPLIT_TO_TABLE(b.categories, ',') category
WHERE b.categories IS NOT NULL
  AND TRIM(category.value::STRING) <> '';
