-- FitAI Storage Buckets Setup for Supabase
-- Run this SQL in your Supabase SQL Editor after running schema.sql

-- ============================================================================
-- STORAGE BUCKETS
-- ============================================================================

-- Create food-photos bucket
-- This bucket stores food photos taken by users for their food entries
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
    'food-photos',
    'food-photos',
    false, -- Set to true if you want public access, false for private (requires signed URLs)
    20971520, -- 20MB file size limit (increased to allow larger images)
    ARRAY['image/jpeg', 'image/jpg', 'image/png', 'image/heic', 'image/heif'] -- Allowed image types
)
ON CONFLICT (id) DO UPDATE SET file_size_limit = 20971520;

-- ============================================================================
-- STORAGE POLICIES (Row Level Security for Storage)
-- ============================================================================

-- Enable RLS on storage.objects (should already be enabled, but ensuring it)
-- Note: RLS is automatically enabled on storage.objects in Supabase

-- Policy: Users can upload their own photos
-- This allows users to upload photos to their own folder (user_id/)
-- File path should be: {user_id}/{filename}
CREATE POLICY "Users can upload their own photos"
ON storage.objects FOR INSERT
WITH CHECK (
    bucket_id = 'food-photos' 
    AND name LIKE auth.uid()::text || '/%'
);

-- Policy: Users can view their own photos
-- This allows users to view/download photos from their own folder
CREATE POLICY "Users can view their own photos"
ON storage.objects FOR SELECT
USING (
    bucket_id = 'food-photos' 
    AND name LIKE auth.uid()::text || '/%'
);

-- Policy: Users can update their own photos
-- This allows users to update/replace their own photos
CREATE POLICY "Users can update their own photos"
ON storage.objects FOR UPDATE
USING (
    bucket_id = 'food-photos' 
    AND name LIKE auth.uid()::text || '/%'
);

-- Policy: Users can delete their own photos
-- This allows users to delete photos from their own folder
CREATE POLICY "Users can delete their own photos"
ON storage.objects FOR DELETE
USING (
    bucket_id = 'food-photos' 
    AND name LIKE auth.uid()::text || '/%'
);

-- ============================================================================
-- NOTES
-- ============================================================================
-- 
-- File Path Structure:
-- Photos should be stored with the following path structure:
--   {user_id}/{photo_id}.{extension}
-- 
-- Example:
--   a1b2c3d4-e5f6-7890-abcd-ef1234567890/550e8400-e29b-41d4-a716-446655440000.jpg
--
-- Public vs Private Bucket:
-- - If bucket is PUBLIC: Photos are accessible via direct URLs
-- - If bucket is PRIVATE: You'll need to generate signed URLs using Supabase Storage API
--
-- To make the bucket public, update the INSERT statement above:
--   public = true
--
-- Or run this after creating the bucket:
--   UPDATE storage.buckets SET public = true WHERE id = 'food-photos';
--
-- ============================================================================

