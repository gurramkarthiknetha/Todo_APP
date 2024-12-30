import 'package:flutter/material.dart';
import 'package:todolist/Widigts/TaskList.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  bool b=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    margin: EdgeInsets.only(top: 30,left: 30,right: 30),
                    child: Text('Add The Task',
                    style: TextStyle(color: Colors.lightBlueAccent,
                      fontSize: 40,
                      fontWeight: FontWeight.w600
                    ),
                    ),
                  ),
                  Container(
                    child: TextField(textAlign: TextAlign.center,autofocus: true,),
                  ),
                  Container(
                    child: OutlinedButton(onPressed: (){}, child: Text('click here to Add ')),
                  )

                ],
              ),
            ),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 40,left: 30),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.list,
                        size: 40,
                      ),

                    ),
                  ),
                  Container(
                    child: Text(
                      'Todoey',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    padding: EdgeInsets.only(left: 20,top: 10),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: TaskList(),
              ),

            )
          ],
        ),
      ),
    );
  }
}
