import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> tasks = [];

  void addTask(String task) {
    setState(() {
      tasks.add({'title': task, 'isChecked': false});
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleCheckbox(int index) {
    setState(() {
      tasks[index]['isChecked'] = !tasks[index]['isChecked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskScreen(
              onAdd: (newTask) {
                addTask(newTask);
                Navigator.pop(context);
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 40, left: 30, bottom: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.list,
                      size: 40,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Todoey',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: TaskList(
                  tasks: tasks,
                  onDelete: deleteTask,
                  onToggle: toggleCheckbox,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final Function(int) onDelete;
  final Function(int) onToggle;

  TaskList({required this.tasks, required this.onDelete, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          taskName: tasks[index]['title'],
          isChecked: tasks[index]['isChecked'],
          onDelete: () => onDelete(index),
          onToggle: () => onToggle(index),
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isChecked;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  TaskTile({required this.taskName, required this.isChecked, required this.onDelete, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskName,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) => onToggle(),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  final Function(String) onAdd;

  AddTaskScreen({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    String newTask = '';

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
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
            onChanged: (value) {
              newTask = value;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
            ),
            onPressed: () {
              if (newTask.isNotEmpty) {
                onAdd(newTask);
              }
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
