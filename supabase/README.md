# Supabase Database Schema

This directory contains SQL scripts for setting up the FitAI database in Supabase.

## Files

- `schema.sql` - Main database schema with tables, indexes, RLS policies, and triggers

## Setup Instructions

1. Open your Supabase project dashboard
2. Go to **SQL Editor**
3. Create a new query
4. Copy and paste the contents of `schema.sql`
5. Run the query
6. Verify tables were created in **Table Editor**

## Database Tables

### users
Stores user profile information (linked to Supabase Auth)

### daily_goals
Stores user's daily calorie and macro goals

### food_entries
Stores food entries with macronutrient information

### photos
Stores photo metadata (actual files in Supabase Storage)

### weight_tracking
Stores weight tracking entries

### daily_summaries
Stores daily calorie/macro summaries (optional, can be computed)

## Row Level Security (RLS)

All tables have RLS enabled with policies that ensure:
- Users can only view their own data
- Users can only modify their own data
- Users cannot access other users' data

## Indexes

Indexes are created on frequently queried columns for better performance:
- `food_entries(user_id, date)` - For querying food entries by user and date
- `daily_goals(user_id, is_active)` - For querying active goals
- And more...

## Triggers

Automatic `updated_at` timestamp updates are handled by triggers on:
- `users`
- `daily_goals`
- `food_entries`
- `daily_summaries`

