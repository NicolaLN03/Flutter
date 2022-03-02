import 'package:flutter/material.dart';
import 'main.dart';
import 'todo.dart';
import 'textfield.dart';
//import './textdisplay.dart';
//import './button.dart';

class InfoLista extends StatelessWidget {
  const InfoLista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get parameters from the previous screen:
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, Todo>; //MyClass;
    // Get title and text parameters:
    final todo = routeArgs['todo'] as Todo;
    // Use the Todo to create the UI.

    void deleteElement(BuildContext context) {
      deleteSelectedTodo(todo);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
      final snackBar = SnackBar(
          content: Text(todo.title.toString() + ' deleted'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextDisplay(todo.description),
            GestureDetector(
              onTap: () async =>{
                deleteElement(context)
              },
              child: Icon(
                Icons.delete,
                color: Colors.black.withOpacity(0.75),
                size: 26.0,
             	),
            )
          ],

        )
        
      )  
    
    );
  }

  
}