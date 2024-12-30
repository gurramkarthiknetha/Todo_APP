import 'package:flutter/material.dart';

class TaskTitle extends StatefulWidget {
  @override
  _TaskTitleState createState() => _TaskTitleState();
}

class _TaskTitleState extends State<TaskTitle> {
  // Track whether the checkbox is checked
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Good morning ',
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      // Add a checkbox to toggle the state
      trailing: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          // Update the state when checkbox is clicked
          setState(() {
            isChecked = value ?? false;
          });
        },
      ),
    );
  }
}
