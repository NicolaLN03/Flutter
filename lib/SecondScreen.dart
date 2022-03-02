import 'package:flutter/material.dart';
import 'package:myp/main.dart';
import 'package:myp/todo.dart';
//import './textdisplay.dart';
//import './button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      titleController.dispose();
      descriptionController.dispose();
      //super.dispose();
    }

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("Aggiungi nuovo elemento alla lista"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Titolo',
          )
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Descrizione',
          )
          ),
          RaisedButton(
            onPressed: () => Navigator.pop(context, Todo(titleController.text, descriptionController.text)),
          child: const Text("SUBMIT"),
          )
        ],
      )
    );
  }
}