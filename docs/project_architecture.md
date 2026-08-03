# Project Architecture

## End-to-End Flow

```mermaid
flowchart LR
    A[Yelp JSON Dataset<br/>Business + Reviews] --> B[Python<br/>Split large review file]
    B --> C[Amazon S3<br/>Raw JSON storage]
    C --> D[Snowflake Stage<br/>Secure storage integration]
    D --> E[Raw VARIANT Tables<br/>COPY INTO]
    E --> F[SQL Transformations<br/>JSON parsing and validation]
    F --> G[Python UDF<br/>TextBlob sentiment]
    G --> H[Analytics Tables<br/>Reviews, Businesses, Categories]
    H --> I[Reporting Views]
    I --> J[Power BI<br/>Four-page dashboard]
```

## Layer Summary

| Layer | Main component | Purpose |
|---|---|---|
| Source | Yelp JSON files | Provide business and review records |
| Extract | Python notebook | Split the multi-gigabyte review file into manageable 10 parts |
| Raw storage | Amazon S3 | Store the original JSON files before warehouse loading |
| Ingestion | Snowflake stage and `COPY INTO` | Load semi-structured JSON into `VARIANT` columns |
| Transformation | Snowflake SQL | Parse JSON fields and create typed analytics tables |
| NLP | Snowflake Python UDF | Classify review text using TextBlob polarity |
| Analytics | SQL queries and reporting views | Answer business, customer, rating, category and location questions |
| Presentation | Power BI | Deliver executive, business, customer and geographic dashboards |

## Why ELT Was Used

The source JSON is loaded into Snowflake before the main transformations are performed. This preserves the raw records, uses Snowflake's semi-structured data support and keeps the transformation logic centralized in reusable SQL scripts.

## Main Design Decisions

- Raw JSON is retained in Snowflake `VARIANT` columns.
- Structured tables use explicit data types for dates, ratings and counts.
- Sentiment classification runs inside Snowflake through a Python UDF.
- Business categories are normalized into a bridge table for accurate category analysis.
- Power BI connects to reporting views rather than directly to raw JSON tables.
- AWS credentials are not embedded in repository files.
