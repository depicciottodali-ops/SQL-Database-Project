-- ============================================================
--  schema.sql
--  Purpose : Create the retail_store database.
--  Run this file FIRST before any other SQL scripts.
--  Usage   : SOURCE sql/schema.sql;
-- ============================================================

-- Drop the database if it already exists (for a clean rebuild)
DROP DATABASE IF EXISTS retail_store;

-- Create a fresh database with UTF-8 character support
CREATE DATABASE retail_store
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Select the database for all subsequent statements
USE retail_store;
