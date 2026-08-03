USE DATABASE YELP_BI;
USE SCHEMA ANALYTICS;

CREATE OR REPLACE FUNCTION ANALYZE_SENTIMENT(review_text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('textblob')
HANDLER = 'sentiment_analyzer'
AS
$$
from textblob import TextBlob

def sentiment_analyzer(review_text):
    if review_text is None or not review_text.strip():
        return 'Neutral'

    polarity = TextBlob(review_text).sentiment.polarity

    if polarity > 0:
        return 'Positive'
    if polarity < 0:
        return 'Negative'
    return 'Neutral'
$$;
