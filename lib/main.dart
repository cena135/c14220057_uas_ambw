import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/get_started_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vwczldishyztvygwiufz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ3Y3psZGlzaHl6dHZ5Z3dpdWZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMDc5MDcsImV4cCI6MjA2NjY4MzkwN30.IiE2zBMxIPlvJH89harCETctkMyhZzT9kIjwHmGwYmQ',
  );
  final prefs = await SharedPreferences.getInstance();
  final seen = prefs.getBool('seen_get_started') ?? false;
  final loggedIn = prefs.getBool('logged_in') ?? false;
  runApp(MyApp(seen: seen, loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool seen;
  final bool loggedIn;
  const MyApp({super.key, required this.seen, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: !seen
          ? const GetStartedScreen()
          : loggedIn
              ? const HomeScreen()
              : const LoginScreen(),
    );
  }
}