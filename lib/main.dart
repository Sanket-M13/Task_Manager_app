import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TaskManagementApp());
}

// TaskManagementApp is the root widget of the application
// It sets up the main theme and home screen of the app.
class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}