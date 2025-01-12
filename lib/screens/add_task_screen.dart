import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';

//This is an AddTaskScreen which use To fill Information about task like Task Name, Due date and priority 
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  DateTime? _dueDate;
  String _priority = 'Low';

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        name: _taskNameController.text,
        dueDate: _dueDate?.toIso8601String(),
        priority: _priority,
      );
      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task',style: GoogleFonts.inriaSans(fontSize: 25, fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Due Date: ',style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),),
                  TextButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      setState(() {
                        _dueDate = selectedDate;
                      });
                    },
                    child: Text(
                      _dueDate == null
                          ? 'Select Date'
                          : _dueDate!.toLocal().toString().split(' ')[0],
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              DropdownButtonFormField<String>(
                value: _priority,
                items: ['High', 'Medium', 'Low']
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Priority'),
              ),
              const SizedBox(height: 32),
              Container(
                height: 50,
                width: 160,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 191, 210, 241))
                  ),
                  onPressed: _saveTask,
                  child: Text('Save Task',style:GoogleFonts.inriaSans(fontSize: 21, fontWeight: FontWeight.w400, color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
