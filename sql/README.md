# Snowflake SQL Scripts

Run the files in numerical order.

| File | Purpose |
|---|---|
| `00_setup_database.sql` | Creates the database and schemas |
| `01_create_raw_tables.sql` | Creates raw `VARIANT` tables and JSON file format |
| `02_load_from_s3.sql` | Creates the S3 stage and loads raw JSON |
| `03_create_sentiment_udf.sql` | Creates the TextBlob sentiment function |
| `04_transform_analytics_tables.sql` | Parses JSON into typed analytics tables |
| `05_create_power_bi_views.sql` | Creates reporting and aggregated views |
| `06_data_quality_checks.sql` | Validates counts, keys, relationships, dates and ratings |
| `07_business_analysis.sql` | Contains the main business-analysis queries |

## Security

`02_load_from_s3.sql` uses placeholders for a Snowflake storage integration. Do not replace those placeholders with credentials in a committed file.

## Expected Schemas

```text
YELP_BI.RAW
YELP_BI.ANALYTICS
YELP_BI.REPORTING
```
