import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<Map<String, dynamic>> tasks = [];

  void _addTask(String task) {
    setState(() {
      tasks.add({'title': task, 'isChecked': false});
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleCheckbox(int index) {
    setState(() {
      tasks[index]['isChecked'] = !tasks[index]['isChecked'];
    });
  }

  void _showAddTaskModal(BuildContext context) {
    String newTask = '';
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) => newTask = value,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
              onPressed: () {
                if (newTask.isNotEmpty) {
                  _addTask(newTask);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskModal(context),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 30, bottom: 20),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.list, size: 40, color: Colors.lightBlueAccent),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Todoey',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: task['isChecked'] ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: task['isChecked'],
                        onChanged: (_) => _toggleCheckbox(index),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
