# 🚀 Quick Setup Guide for Mini TaskHub

## Step 1: Create Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Fill in project details:
   - Name: `Mini TaskHub` (or any name you prefer)
   - Database Password: Create a strong password
   - Region: Choose closest to your location
5. Wait for project creation (2-3 minutes)

## Step 2: Set Up Database

1. In your Supabase dashboard, go to "SQL Editor"
2. Click "New Query"
3. Copy and paste this SQL code:

```sql
-- Create tasks table
CREATE TABLE tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  is_completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  due_date TIMESTAMP WITH TIME ZONE
);

-- Enable Row Level Security
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- Create policies for tasks table
CREATE POLICY "Users can view their own tasks" ON tasks
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own tasks" ON tasks
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own tasks" ON tasks
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own tasks" ON tasks
  FOR DELETE USING (auth.uid() = user_id);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

4. Click "Run" to execute the SQL

## Step 3: Get Your Credentials

1. In Supabase dashboard, go to "Settings" → "API"
2. Copy these two values:
   - **Project URL** (looks like: `https://abcdefghijk.supabase.co`)
   - **anon public key** (long string starting with `eyJ...`)

## Step 4: Configure Flutter App

1. Open `lib/main.dart` in your code editor
2. Find lines 13-14 (around the top of the file)
3. Replace the placeholder values:

```dart
// BEFORE (placeholder values):
const supabaseUrl = 'YOUR_SUPABASE_URL';
const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

// AFTER (your actual values):
const supabaseUrl = 'https://your-project-id.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

## Step 5: Run the App

```bash
flutter pub get
flutter run
```

## Step 6: Test the App

1. Click "Sign Up" to create a new account
2. Enter your email and password
3. After signing up, you'll be logged in automatically
4. Try adding a task using the + button
5. Test task completion, editing, and deletion

## 🎉 You're Done!

Your Mini TaskHub app is now fully configured with:
- ✅ Real Supabase authentication
- ✅ Real-time task synchronization
- ✅ Secure data storage
- ✅ Light/dark theme toggle
- ✅ Responsive design

## 🔧 Optional: Enable Real-time Updates

For real-time task synchronization across devices:

1. In Supabase dashboard, go to "Database" → "Replication"
2. Find the `tasks` table
3. Toggle "Enable" for real-time updates

## 🆘 Need Help?

- Check the main README.md for detailed documentation
- Look at the Troubleshooting section for common issues
- Ensure your Supabase project is active and not paused
- Verify your internet connection

## 🔒 Security Notes

- The anon key is safe to use in client-side code
- Row Level Security ensures users only see their own tasks
- Never commit your actual credentials to version control
- For production, consider using environment variables