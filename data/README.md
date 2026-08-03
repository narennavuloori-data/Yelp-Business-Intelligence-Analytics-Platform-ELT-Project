# Data Folder

The raw Yelp files are not stored in this GitHub repository because the review dataset is several gigabytes and exceeds normal GitHub file limits.

## Expected Folder Structure

```text
data/
├── raw/
│   ├── yelp_academic_dataset_business.json
│   └── yelp_academic_dataset_review.json
└── processed/
    ├── split_file_01.json
    ├── split_file_02.json
    └── ...
```

## Dataset Used

| File | Purpose |
|---|---|
| Business JSON | Business name, city, state, stars, review count and categories |
| Review JSON | User, business, date, star rating and review text |

## Important

Do not commit the raw or processed JSON files. The `.gitignore` file excludes these directories while keeping the folder structure visible.
