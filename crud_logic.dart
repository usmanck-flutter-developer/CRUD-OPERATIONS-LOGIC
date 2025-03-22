import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Start the app
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: TodoApp(), // Load the TODO app
    );
  }
}

// Stateful Widget for TODO App
class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> tasks = []; // List to store tasks
  TextEditingController taskController = TextEditingController(); // Controller for text input

  // ✅ Function to Add Task
  void addTask() {
    setState(() {
      tasks.add(taskController.text); // Add new task to the list
      taskController.clear(); // Clear the input field
    });
  }

  // ✅ Function to Update Task
  void updateTask(int index) {
    TextEditingController updateController =
        TextEditingController(text: tasks[index]); // Pre-fill text field with current task

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"), // Dialog title
          content: TextField(controller: updateController), // Text input field
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks[index] = updateController.text; // Update task in list
                });
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  // ✅ Function to Delete Task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index); // Remove task from list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TODO App")), // App Bar with title
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                // Input Field for New Task
                Expanded(
                  child: TextField(
                    controller: taskController, // Controller for task input
                    decoration: InputDecoration(hintText: "Enter task..."),
                  ),
                ),
                SizedBox(width: 10),
                // Add Task Button
                ElevatedButton(
                  onPressed: addTask,
                  child: Text("Add"),
                ),
              ],
            ),
          ),

          // ✅ Displaying Tasks (READ OPERATION)
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length, // Number of tasks
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]), // Show task text
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button ✏
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => updateTask(index),
                      ),
                      // Delete Button ❌
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTask(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
