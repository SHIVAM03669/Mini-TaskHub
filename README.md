# Mini TaskHub

A personal task tracker built with Flutter and Supabase. Mini TaskHub helps you organize and manage your daily tasks with a clean, modern interface supporting both light and dark themes.

## Features

- **User Authentication**: Secure email/password authentication with Supabase
- **Task Management**: Create, read, update, and delete tasks with real-time sync
- **Real-time Updates**: Tasks are synchronized across devices using Supabase Realtime
- **Theme Toggle**: Switch between light and dark themes
- **Modern UI**: Clean Material 3 design with smooth animations
- **Task Editing**: Edit tasks inline or through context menu
- **Responsive Design**: Works on mobile, tablet, and web

## Tech Stack

- **Flutter**: Latest stable version for cross-platform development
- **Supabase**: Backend-as-a-Service for authentication and database
- **Provider**: State management solution
- **Material 3**: Modern UI design system
- **Google Fonts**: Poppins font family

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   └── theme.dart           # App theme configuration (light/dark)
├── auth/
│   ├── login_screen.dart    # Login UI
│   ├── signup_screen.dart   # Registration UI
│   └── auth_service.dart    # Authentication logic
├── dashboard/
│   ├── dashboard_screen.dart # Main task dashboard
│   ├── task_tile.dart       # Task list item widget
│   └── task_model.dart      # Task data model
├── models/
│   ├── task.dart           # Task data model
│   └── user.dart           # User data model
├── providers/
│   ├── auth_provider.dart  # Authentication state management
│   ├── task_provider.dart  # Task state management
│   └── theme_provider.dart # Theme state management
├── services/
│   └── supabase_service.dart # Supabase API integration
└── utils/
    └── validators.dart      # Form validation utilities
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or later)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Supabase account (free tier available)

### 1. Clone the Repository

```bash
git clone <repository-url>
cd mini_taskhub
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Supabase Configuration

#### Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new account
2. Click "New Project" and fill in your project details
3. Wait for the project to be set up completely (this may take a few minutes)

#### Set up the Database Schema

1. Go to your Supabase project dashboard
2. Navigate to the "SQL Editor" tab
3. Run the following SQL to create the tasks table:

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

#### Enable Realtime (Optional but Recommended)

1. Go to the "Database" tab in your Supabase dashboard
2. Click on "Replication" in the sidebar
3. Enable replication for the `tasks` table to get real-time updates

#### Configure Flutter App

1. In your Supabase project dashboard, go to "Settings" → "API"
2. Copy your Project URL and anon/public key
3. Update `lib/main.dart` with your credentials:

```dart
// Replace these lines in lib/main.dart (around line 13-14):
const supabaseUrl = 'https://your-project-id.supabase.co';
const supabaseAnonKey = 'your-anon-key-here';
```

**Example:**
```dart
const supabaseUrl = 'https://abcdefghijklmnop.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

**⚠️ Important Security Notes:**
- Never commit your actual Supabase credentials to version control
- For production apps, use environment variables or secure configuration
- The anon key is safe to use in client-side code (it's designed for this purpose)

### 4. Run the App

```bash
# For mobile development
flutter run

# For web development
flutter run -d chrome

# For desktop development (Windows)
flutter run -d windows
```

## Hot Reload vs Hot Restart in Flutter

### Hot Reload ⚡
- **What it does**: Injects updated source code files into the running Dart Virtual Machine (VM)
- **When to use**: For UI changes, adding new widgets, modifying existing widget properties
- **Speed**: Very fast (usually under 1 second)
- **Preserves**: App state, variable values, navigation stack
- **Shortcut**: `r` in terminal or `Ctrl+S` in most IDEs
- **Best for**: Tweaking UI, adjusting layouts, changing colors/styles

### Hot Restart 🔄
- **What it does**: Restarts the entire app from scratch
- **When to use**: When changing app initialization code, adding new dependencies, modifying main() function
- **Speed**: Slower than hot reload (few seconds)
- **Resets**: All app state, returns to initial route
- **Shortcut**: `R` in terminal or `Ctrl+Shift+F5` in most IDEs

### When Hot Reload Won't Work
- Changes to `main()` function
- Changes to global variables and static fields
- Changes to enum values
- Changes to generic type declarations
- Changes to method signatures
- Adding new dependencies to pubspec.yaml

In these cases, use Hot Restart instead.

## Usage Guide

### Getting Started
1. **Sign Up**: Create a new account with your email and password
2. **Sign In**: Log in with your credentials
3. **Dashboard**: View your tasks in a clean, organized interface

### Managing Tasks
- **Add Tasks**: Tap the floating action button (+) to add new tasks
- **Mark Complete**: Tap the checkbox to mark tasks as completed
- **Edit Tasks**: Long press a task or use the menu to edit
- **Delete Tasks**: Swipe left on a task or use the context menu
- **Real-time Sync**: Changes are automatically synced across all your devices

### Customization
- **Theme Toggle**: Use the theme button in the app bar to switch between light and dark modes
- **Sign Out**: Use the logout button in the app bar to sign out securely

## Features Implemented

✅ **Authentication**
- Email/password sign up and sign in
- Secure session management
- Automatic logout on session expiry

✅ **Task Management**
- Create, read, update, delete tasks
- Mark tasks as complete/incomplete
- Real-time synchronization
- Task editing with inline and dialog options

✅ **UI/UX**
- Material 3 design system
- Light and dark theme support
- Smooth animations and transitions
- Responsive design for all screen sizes
- Loading states and error handling

✅ **State Management**
- Provider pattern for clean architecture
- Proper separation of concerns
- Error handling and loading states

✅ **Real-time Updates**
- Supabase Realtime integration
- Automatic UI updates when data changes
- Offline-first approach with sync

## Testing

Run the unit tests:

```bash
flutter test
```

The project includes unit tests for the Task model to ensure proper JSON serialization and deserialization.

## Troubleshooting

### Common Issues

1. **"YOUR_SUPABASE_URL" 404 Error**
   - This means you haven't configured your Supabase credentials yet
   - Update the `supabaseUrl` and `supabaseAnonKey` constants in `lib/main.dart`
   - Make sure to use your actual project URL and anon key from Supabase dashboard

2. **Supabase Connection Error**
   - Verify your Supabase URL and anon key are correct
   - Check that your Supabase project is active and not paused
   - Ensure you have internet connectivity
   - Try accessing your Supabase dashboard to confirm the project is working

3. **Authentication Issues**
   - Verify email confirmation is disabled in Supabase Auth settings (for development)
   - Check that Row Level Security policies are properly configured
   - Ensure the tasks table exists with the correct schema

4. **Real-time Updates Not Working**
   - Ensure Realtime is enabled for the tasks table in Supabase
   - Check that your subscription is active in the Supabase dashboard
   - Verify your internet connection is stable

5. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Ensure you're using Flutter 3.0.0 or later
   - Check that all dependencies are compatible
   - Restart your IDE/editor

### Getting Your Supabase Credentials

1. Go to [supabase.com](https://supabase.com) and sign in
2. Select your project (or create a new one)
3. Go to Settings → API
4. Copy the "Project URL" and "anon public" key
5. Replace the placeholders in `lib/main.dart`

### Database Setup Verification

To verify your database is set up correctly, run this query in your Supabase SQL editor:

```sql
-- Check if tasks table exists
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' AND table_name = 'tasks';

-- Check if RLS is enabled
SELECT schemaname, tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'tasks';
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests if applicable
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have questions:
1. Check the troubleshooting section above
2. Create an issue in the repository with detailed information
3. Include your Flutter version, platform, and error messages

## Roadmap

Future enhancements planned:
- [ ] Task categories and tags
- [ ] Due date reminders
- [ ] Task priority levels
- [ ] Search and filter functionality
- [ ] Export tasks to different formats
- [ ] Collaborative task sharing