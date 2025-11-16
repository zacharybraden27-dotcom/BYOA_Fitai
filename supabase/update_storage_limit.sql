-- Update existing storage bucket file size limit to 20MB
-- Run this SQL in your Supabase SQL Editor to update the existing bucket

UPDATE storage.buckets 
SET file_size_limit = 20971520  -- 20MB in bytes
WHERE id = 'food-photos';

-- Verify the update
SELECT id, name, file_size_limit, 
       ROUND(file_size_limit / 1024.0 / 1024.0, 2) as file_size_limit_mb
FROM storage.buckets 
WHERE id = 'food-photos';

