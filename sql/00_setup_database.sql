-- Run with a role that can create a database and schemas.
-- Select an active Snowflake warehouse before running the remaining scripts.

CREATE DATABASE IF NOT EXISTS YELP_BI;

CREATE SCHEMA IF NOT EXISTS YELP_BI.RAW;
CREATE SCHEMA IF NOT EXISTS YELP_BI.ANALYTICS;
CREATE SCHEMA IF NOT EXISTS YELP_BI.REPORTING;

USE DATABASE YELP_BI;
