// Represents a Task with properties such as name, due date, priority, and completion status.
class Task {
  String name;
  String? dueDate;
  String priority;
  bool isCompleted;

  Task({
    required this.name,
    this.dueDate,
    this.priority = 'Low',
    this.isCompleted = false,
  });
   // Converts a Task object to a map (for saving to local storage or database)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dueDate': dueDate,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }
  // Creates a Task object from a map (for loading from local storage or database)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      dueDate: map['dueDate'],
      priority: map['priority'],
      isCompleted: map['isCompleted'],
    );
  }
}