# Supabase Integration Checklist

Use this checklist to track your Supabase setup progress.

## Initial Setup
- [ ] Create Supabase account
- [ ] Create new Supabase project
- [ ] Save project credentials securely
- [ ] Get Project URL from Settings → API
- [ ] Get anon public key from Settings → API
- [ ] Get service_role key from Settings → API (keep secret!)

## Database Setup
- [ ] Run `supabase/schema.sql` in SQL Editor
- [ ] Verify all tables were created:
  - [ ] `users`
  - [ ] `daily_goals`
  - [ ] `food_entries`
  - [ ] `photos`
  - [ ] `weight_tracking`
  - [ ] `daily_summaries`
- [ ] Verify indexes were created
- [ ] Verify RLS policies were created
- [ ] Verify triggers were created

## Authentication Setup
- [ ] Enable Email provider in Authentication → Providers
- [ ] Configure email settings (confirm email on/off)
- [ ] Test sign up flow
- [ ] Test sign in flow
- [ ] Test sign out flow

## Storage Setup
- [ ] Create `food-photos` storage bucket
- [ ] Set bucket to Public or Private
- [ ] Create storage policies (if Private)
- [ ] Test photo upload
- [ ] Test photo retrieval

## App Configuration
- [ ] Update `AppConfig.swift` with Supabase URL
- [ ] Update `AppConfig.swift` with anon key
- [ ] Set `useMockData = false` in `AppConfig.swift`
- [ ] Verify app builds without errors

## Service Integration
- [ ] Implement `SupabaseService.signUp()`
- [ ] Implement `SupabaseService.signIn()`
- [ ] Implement `SupabaseService.signOut()`
- [ ] Implement `SupabaseService.getCurrentUser()`
- [ ] Implement `SupabaseService.getFoodEntries()`
- [ ] Implement `SupabaseService.createFoodEntry()`
- [ ] Implement `SupabaseService.updateFoodEntry()`
- [ ] Implement `SupabaseService.deleteFoodEntry()`
- [ ] Implement `SupabaseService.getActiveGoal()`
- [ ] Implement `SupabaseService.createGoal()`
- [ ] Implement `SupabaseService.updateGoal()`
- [ ] Implement `SupabaseService.updateUser()`
- [ ] Implement `SupabaseService.uploadPhoto()`
- [ ] Implement `SupabaseService.deletePhoto()`

## Update Existing Services
- [ ] Update `AuthService` to use Supabase
- [ ] Update `DatabaseService` to use Supabase
- [ ] Update `PhotoService` to use Supabase Storage
- [ ] Remove or disable mock data service

## Testing
- [ ] Test user sign up
- [ ] Test user sign in
- [ ] Test user sign out
- [ ] Test creating food entry
- [ ] Test reading food entries
- [ ] Test updating food entry
- [ ] Test deleting food entry
- [ ] Test creating goal
- [ ] Test reading goal
- [ ] Test updating goal
- [ ] Test photo upload
- [ ] Test photo retrieval
- [ ] Test RLS policies (users can only see their data)

## Security Review
- [ ] Verify RLS policies are working
- [ ] Verify service_role key is not in app
- [ ] Verify anon key is safe to use
- [ ] Verify all API calls use authentication
- [ ] Verify storage policies are correct

## Documentation
- [ ] Document any custom configurations
- [ ] Document environment variables
- [ ] Update setup instructions if needed
- [ ] Create backup of database schema

## Deployment
- [ ] Set up production Supabase project (if needed)
- [ ] Configure production environment variables
- [ ] Test in production environment
- [ ] Set up database backups
- [ ] Monitor Supabase usage and limits

---

## Quick Reference

### Supabase Dashboard URLs
- **Project Settings**: `https://app.supabase.com/project/[project-id]/settings`
- **SQL Editor**: `https://app.supabase.com/project/[project-id]/sql`
- **Table Editor**: `https://app.supabase.com/project/[project-id]/editor`
- **Authentication**: `https://app.supabase.com/project/[project-id]/auth/users`
- **Storage**: `https://app.supabase.com/project/[project-id]/storage/buckets`

### Key Files to Update
- `FitAI/FitAI/FitAI/FitAI/App/AppConfig.swift` - Add Supabase credentials
- `FitAI/FitAI/FitAI/FitAI/Services/SupabaseService.swift` - Implement methods
- `FitAI/FitAI/FitAI/FitAI/Services/AuthService.swift` - Use Supabase
- `FitAI/FitAI/FitAI/FitAI/Services/DatabaseService.swift` - Use Supabase
- `FitAI/FitAI/FitAI/FitAI/Services/PhotoService.swift` - Use Supabase Storage

### Important Notes
- ⚠️ Never commit `service_role` key to git
- ✅ `anon` key is safe for client-side use (protected by RLS)
- ✅ RLS ensures users can only access their own data
- ✅ All tables have RLS enabled with appropriate policies

