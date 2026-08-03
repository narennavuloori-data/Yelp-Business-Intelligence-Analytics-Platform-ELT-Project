# Data Dictionary

## Raw Layer

### `RAW.YELP_REVIEWS`

| Column | Type | Description |
|---|---|---|
| `review_text` | `VARIANT` | Complete JSON review record loaded from Amazon S3 |

### `RAW.YELP_BUSINESSES`

| Column | Type | Description |
|---|---|---|
| `business_text` | `VARIANT` | Complete JSON business record loaded from Amazon S3 |

## Analytics Layer

### `ANALYTICS.REVIEWS`

| Column | Type | Description |
|---|---|---|
| `business_id` | `VARCHAR` | Business referenced by the review |
| `review_date` | `DATE` | Date the review was submitted |
| `user_id` | `VARCHAR` | Anonymous Yelp user identifier |
| `review_stars` | `NUMBER(2,1)` | Review rating from one to five stars |
| `review_text` | `VARCHAR` | Written review content |
| `review_length` | `NUMBER` | Character count of the written review |
| `sentiment` | `VARCHAR` | TextBlob classification: Positive, Neutral or Negative |

### `ANALYTICS.BUSINESSES`

| Column | Type | Description |
|---|---|---|
| `business_id` | `VARCHAR` | Unique Yelp business identifier |
| `name` | `VARCHAR` | Displayed business name |
| `city` | `VARCHAR` | Business city |
| `state` | `VARCHAR` | Business state or regional code |
| `source_review_count` | `NUMBER` | Review count contained in the source business JSON |
| `business_stars` | `NUMBER(2,1)` | Source-level average business rating |
| `categories` | `VARCHAR` | Original comma-separated category string |

### `ANALYTICS.BRIDGE_BUSINESS_CATEGORY`

| Column | Type | Description |
|---|---|---|
| `business_id` | `VARCHAR` | Business identifier |
| `category` | `VARCHAR` | One normalized business category |

## Reporting Views

| View | Purpose |
|---|---|
| `REPORTING.VW_REVIEWS` | Review-level Power BI source |
| `REPORTING.VW_BUSINESSES` | Business-level Power BI source |
| `REPORTING.VW_BUSINESS_CATEGORIES` | Normalized category source |
| `REPORTING.VW_BUSINESS_PERFORMANCE` | Pre-aggregated business metrics |
| `REPORTING.VW_GEOGRAPHIC_PERFORMANCE` | State and city performance metrics |

## Power BI Naming

The report uses the following simplified table names:

```text
REPORTING.VW_REVIEWS     → REVIEWS
REPORTING.VW_BUSINESSES  → BUSINESSES
```
