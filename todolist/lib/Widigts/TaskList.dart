import 'package:flutter/material.dart';
import 'package:todolist/Screens/TodoList.dart';
import 'TaskTitles.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final bool b=false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TaskTitle(),
        TaskTitle(),
      ],
    );
  }
}
