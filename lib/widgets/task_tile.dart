import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';

// TaskTile is a widget that displays a task and provides buttons for editing, deleting, and toggling its completion status.
class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 177, 217, 250),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          task.name,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          '${task.dueDate != null ? 'Due: ${task.dueDate!.split('T')[0]}\n' : ''}Priority: ${task.priority}',
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
