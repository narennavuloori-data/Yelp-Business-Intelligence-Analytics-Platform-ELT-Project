# Power BI Report

## Expected Report File

```text
power-bi/yelp_business_intelligence_platform.pbix
```

The `.pbix` binary was not included in the source files used to generate this repository. Copy the completed Power BI file into this folder before publishing it, or upload it separately through Git LFS when it exceeds GitHub's normal file-size limit.

## Data Sources

Recommended Snowflake views:

```text
REPORTING.VW_REVIEWS
REPORTING.VW_BUSINESSES
REPORTING.VW_BUSINESS_CATEGORIES
REPORTING.VW_BUSINESS_PERFORMANCE
REPORTING.VW_GEOGRAPHIC_PERFORMANCE
```

Rename the two main tables in Power BI as:

```text
VW_REVIEWS     → REVIEWS
VW_BUSINESSES  → BUSINESSES
```

## Relationship

```text
BUSINESSES[business_id]  1 ───────── *  REVIEWS[business_id]
```

Use a single-direction relationship from `BUSINESSES` to `REVIEWS`.

## Included Files

- `dax_measures.dax` — measures used across all four report pages
- `yelp_theme.json` — reusable Power BI theme based on the dashboard design

## Report Pages

1. Executive Overview
2. Business Performance
3. Customer & Sentiment Insights
4. Geographic Intelligence & Category Insights

## Recommended Improvement

The screenshot shows a legacy map visual retirement warning. Replace that visual with Azure Maps before publishing a future version.
