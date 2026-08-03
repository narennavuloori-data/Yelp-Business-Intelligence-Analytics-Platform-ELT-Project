# Power BI Dashboard Documentation

## Report Theme

| Element | Value |
|---|---|
| Primary red | `#FF1A1A` |
| Light card background | `#FCE8E8` |
| Main background | `#FFFFFF` |
| Primary text | `#111111` |
| Positive sentiment | `#FF1A1A` in the current report |
| Negative sentiment | `#7A2026` |
| Neutral sentiment | `#2ECC71` |

## Shared Model

```text
BUSINESSES[business_id]  1 ───────── *  REVIEWS[business_id]
```

All pages use state, city, business/category or sentiment slicers depending on the analytical purpose.

## Page 1 — Executive Overview

### KPI cards

| KPI | Measure |
|---|---|
| Total Businesses | `[Total Businesses]` |
| Total Reviews | `[Total Reviews]` |
| Active Customers | `[Active Customers]` |
| Sentiment Score | `[Sentiment Score]` |
| Business Rating Difference | `[Business Rating Difference]` |
| Average Reviews per Business | `[Average Reviews per Business]` |

### Visuals

| Visual | Axis / legend | Value |
|---|---|---|
| Review trend area chart | `REVIEWS[review_date]` | `[Total Reviews]` |
| Sentiment donut | `REVIEWS[sentiments]` | `[Total Reviews]` |
| Top states bar chart | `BUSINESSES[state]` | `[Total Reviews]` |
| Rating distribution column chart | `REVIEWS[review_stars]` | `[Total Reviews]` |

## Page 2 — Business Performance

### KPI cards

| KPI | Measure / field |
|---|---|
| Average Business Rating | `[Average Business Rating]` |
| Five-Star % | `[Five Star %]` |
| Positive Sentiment % | `[Positive Sentiment %]` |
| Most Reviewed Business | `BUSINESSES[name]` and `[Review Count]`, Top 1 by review count |

### Visuals

| Visual | Axis / rows | Value |
|---|---|---|
| Top businesses by review count | `BUSINESSES[name]` | `[Review Count]` |
| Top businesses by average rating | `BUSINESSES[name]` | `[Average Rating Business]` |
| Detailed performance table | Name, city, state | Review count, average rating, five-star %, positive sentiment % |

## Page 3 — Customer & Sentiment Insights

### KPI cards

| KPI | Measure |
|---|---|
| Active Customers | `[Active Customers]` |
| Reviews per Customer | `[Reviews per Customer]` |
| Positive Reviews | `[Positive Count]` |
| Neutral Reviews | `[Neutral Count]` |
| Negative Reviews | `[Negative Count]` |
| Positive % | `[Positive %]` |
| Average Review Length | `[Average Review Length]` |

### Visuals

| Visual | Axis / rows | Legend / values |
|---|---|---|
| Top active customers | `REVIEWS[user_id]` | `[Total Reviews]` |
| Sentiment by rating | `REVIEWS[review_stars]` | `REVIEWS[sentiments]`, `[Total Reviews]` |
| Detailed customer table | `REVIEWS[user_id]` | Total, positive, neutral and negative counts |

## Page 4 — Geographic Intelligence & Category Insights

### KPI cards

| KPI | Measure |
|---|---|
| Total States | `[Total States]` |
| Total Cities | `[Total Cities]` |
| Business Count | `[Business Count]` |
| Average City Rating | `[City Average Rating]` |
| Reviews per Business | `[Reviews per Business]` |

### Visuals

| Visual | Location / axis | Value |
|---|---|---|
| Map | `BUSINESSES[state]` | `[Business Count]` |
| Top cities | `BUSINESSES[city]` | `[Business Count]` |
| Top categories | Normalized category field | `[Business Count]` |
| Geographic table | State and city | Business count, reviews, rating, reviews per business |

## Performance Notes

- Precompute `review_length` in Snowflake instead of evaluating `LEN(review_text)` over almost seven million rows during every Power BI query.
- Hide `review_text` from report view when detailed text is not required.
- Use a normalized category bridge for category slicers.
- Replace the legacy map visual with Azure Maps.
- Use `business_id` rather than business name for unique location ranking.
