import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import '../widgets/task_tile.dart';

// HomeScreen is the main screen that displays the list of tasks and provides options for adding, editing, and deleting tasks.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }
  // Loads tasks from shared preferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksData = prefs.getString('tasks');
    if (tasksData != null) {
      final List<dynamic> decodedData = jsonDecode(tasksData);
      setState(() {
        _tasks = decodedData.map((data) => Task.fromMap(data)).toList();
      });
    }
  }
  // Saves tasks to shared preferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = jsonEncode(_tasks.map((task) => task.toMap()).toList());
    await prefs.setString('tasks', encodedData);
  }
  // Adds a new task to the list
  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
    _saveTasks();
  }
  // Toggles the completion status of a task
  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
    _saveTasks();
  }
  // Deletes a task from the list
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management',style: GoogleFonts.inriaSans(fontSize: 25, fontWeight: FontWeight.w400)),
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Text("No Tasks Added Yet!", style:GoogleFonts.inriaSans(fontSize: 25, fontWeight: FontWeight.w400) ,),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return TaskTile(
                  task: task,
                  onToggle: () => _toggleTaskStatus(index),
                  onDelete: () => _deleteTask(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
          if (newTask != null && newTask is Task) {
            _addTask(newTask);
          }
        },
        backgroundColor: Color.fromARGB(255, 191, 210, 241),
        shape: const CircleBorder(),
        child: const Icon(Icons.add,size: 40,),
      ),
    );
  }
}