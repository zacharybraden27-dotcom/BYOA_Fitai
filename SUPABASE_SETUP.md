# Supabase Setup Guide for FitAI

This guide will help you set up Supabase as the backend for the FitAI app.

## Prerequisites

1. A Supabase account (sign up at https://supabase.com)
2. Your Supabase project created

## Step 1: Create Supabase Project

1. Go to https://supabase.com and sign in
2. Click "New Project"
3. Fill in project details:
   - **Name**: FitAI (or your preferred name)
   - **Database Password**: Create a strong password (save this!)
   - **Region**: Choose closest to your users
4. Click "Create new project"
5. Wait for project to be provisioned (2-3 minutes)

## Step 2: Get Your Supabase Credentials

1. In your Supabase project dashboard, go to **Settings** → **API**
2. Copy the following values:
   - **Project URL**: `https://your-project-id.supabase.co`
   - **anon public key**: This is your public API key
   - **service_role key**: Keep this secret (server-side only)

## Step 3: Configure the App

1. Open `FitAI/FitAI/FitAI/FitAI/App/AppConfig.swift`
2. Replace the placeholder values:

```swift
static let supabaseURL = "https://your-project-id.supabase.co" // Your Project URL
static let supabaseAnonKey = "your-supabase-anon-key" // Your anon public key
```

## Step 4: Create Database Tables

1. In your Supabase project, go to **SQL Editor**
2. Click "New query"
3. Copy and paste the entire contents of `supabase/schema.sql`
4. Click "Run" to execute the SQL
5. Verify tables were created by going to **Table Editor**

You should see these tables:
- `users`
- `daily_goals`
- `food_entries`
- `photos`
- `weight_tracking`
- `daily_summaries`

## Step 5: Set Up Authentication

1. In Supabase dashboard, go to **Authentication** → **Providers**
2. Enable **Email** provider (should be enabled by default)
3. Configure email settings:
   - Enable "Confirm email" if you want email verification
   - Or disable it for development/testing

## Step 6: Set Up Storage (for Photos)

1. In Supabase dashboard, go to **Storage**
2. Click "Create a new bucket"
3. Name: `food-photos`
4. Make it **Public** if you want photos accessible via URL
   - Or **Private** if you want to use signed URLs
5. Click "Create bucket"

### Storage Policies (if Private)

If you made the bucket private, create a policy:

1. Go to **Storage** → **Policies**
2. Click "New Policy" for `food-photos` bucket
3. Policy name: "Users can upload their own photos"
4. Policy definition:
```sql
-- Allow users to upload their own photos
CREATE POLICY "Users can upload their own photos"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'food-photos' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Allow users to view their own photos
CREATE POLICY "Users can view their own photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'food-photos' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Allow users to delete their own photos
CREATE POLICY "Users can delete their own photos"
ON storage.objects FOR DELETE
USING (bucket_id = 'food-photos' AND auth.uid()::text = (storage.foldername(name))[1]);
```

## Step 7: Update App Configuration

1. Open `FitAI/FitAI/FitAI/FitAI/App/AppConfig.swift`
2. Set `useMockData = false` to enable Supabase:

```swift
static let useMockData = false // Enable Supabase
```

## Step 8: Install Supabase Swift SDK (Optional but Recommended)

For better integration, you can use the official Supabase Swift SDK:

1. In Xcode, go to **File** → **Add Packages...**
2. Enter: `https://github.com/supabase/supabase-swift`
3. Select the package and click "Add Package"
4. Choose the `Supabase` product

Then update `SupabaseService.swift` to use the SDK instead of raw HTTP requests.

## Step 9: Test the Connection

1. Build and run the app
2. Try signing up with a new account
3. Check Supabase dashboard → **Authentication** → **Users** to see if user was created
4. Try adding a food entry and check **Table Editor** → **food_entries**

## Troubleshooting

### Issue: "Invalid API key"
- **Solution**: Double-check your `supabaseAnonKey` in `AppConfig.swift`
- Make sure you're using the **anon public** key, not the service_role key

### Issue: "Row Level Security policy violation"
- **Solution**: Check that RLS policies were created correctly
- Verify the SQL in `supabase/schema.sql` ran successfully
- Check **Authentication** → **Policies** in Supabase dashboard

### Issue: "Table does not exist"
- **Solution**: Make sure you ran the SQL schema file
- Check **Table Editor** to verify tables exist
- Re-run `supabase/schema.sql` if needed

### Issue: "Storage bucket not found"
- **Solution**: Create the `food-photos` bucket in Storage
- Verify the bucket name matches `AppConfig.photoStorageBucket`

## Next Steps

After Supabase is set up:

1. Update `SupabaseService.swift` to implement all methods
2. Update `AuthService.swift` to use Supabase Auth
3. Update `DatabaseService.swift` to use Supabase queries
4. Update `PhotoService.swift` to use Supabase Storage
5. Test all CRUD operations
6. Remove mock data service (or keep for testing)

## Security Notes

- ⚠️ **Never commit** your `service_role` key to git
- ✅ The `anon` key is safe to use in the app (protected by RLS)
- ✅ Row Level Security (RLS) ensures users can only access their own data
- ✅ All API requests should use the anon key with user authentication tokens

## Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Swift SDK](https://github.com/supabase/supabase-swift)
- [Supabase Auth Guide](https://supabase.com/docs/guides/auth)
- [Supabase Storage Guide](https://supabase.com/docs/guides/storage)
- [Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)

