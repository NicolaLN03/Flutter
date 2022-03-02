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
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextDisplay(todo.description),
          ],
        )
        
      )  
    
    );
  }
}