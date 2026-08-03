# Business Requirements

## Project Goal

Build a cloud-based business intelligence platform that transforms Yelp business and review JSON files into reliable, interactive insights for business performance, customer sentiment, geography and category analysis.

## Stakeholders

- Business and regional managers
- Strategy and operations teams
- Customer experience teams
- Marketing and category teams
- Data and business intelligence analysts

## Core Business Questions

### Executive Overview

- How many businesses, reviews and unique reviewers are represented?
- What is the overall sentiment score?
- How does review activity change over time?
- Which states generate the most review activity?
- How are reviews distributed across one to five stars?

### Business Performance

- Which business names receive the most reviews?
- Which businesses maintain the highest average review ratings?
- What percentage of reviews are five-star?
- What percentage of reviews are classified as positive?
- How does performance vary by state, city and category?

### Customer & Sentiment

- How many unique customers leave reviews?
- How many reviews does the average customer submit?
- How many reviews are positive, neutral and negative?
- Which customers are the most active reviewers?
- How does sentiment vary across review-star ratings?
- How detailed is the average written review?

### Geographic & Category

- How many states and cities are represented?
- Which cities contain the highest number of businesses?
- Which categories contain the most businesses?
- How do review volume and average rating vary by location?

## Functional Requirements

1. Load Yelp business and review JSON files from Amazon S3 into Snowflake.
2. Preserve raw JSON in Snowflake `VARIANT` tables.
3. Transform source fields into typed analytics tables.
4. Classify review text into Positive, Neutral and Negative sentiment.
5. Validate row counts, keys, dates, ratings and relationships.
6. Provide reusable SQL business-analysis queries.
7. Connect Power BI to analytics-ready views.
8. Create four interactive dashboard pages with consistent slicers and formatting.
9. Document calculations, assumptions and limitations.
10. Remove credentials and other sensitive values before publishing.

## Non-Functional Requirements

- **Accuracy:** Measures and SQL queries must use consistent definitions.
- **Performance:** Power BI should avoid unnecessary raw columns where possible.
- **Security:** No cloud credentials may be committed to GitHub.
- **Usability:** Dashboard pages must be understandable without reading the SQL.
- **Reproducibility:** Scripts must run in a clear sequence.
- **Maintainability:** Tables, views and measures must use readable names.

## Acceptance Criteria

- [x] Large review JSON split into smaller files with Python
- [x] Raw JSON stored in Amazon S3
- [x] Snowflake raw tables created
- [x] JSON data loaded using `COPY INTO`
- [x] Structured review and business tables created
- [x] TextBlob sentiment UDF created
- [x] SQL business analysis completed
- [x] Power BI dashboard contains four pages
- [x] Dashboard screenshots included
- [x] DAX measures documented
- [x] Credentials removed from public repository files
