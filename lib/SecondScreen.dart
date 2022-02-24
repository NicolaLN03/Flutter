import 'package:flutter/material.dart';
import 'package:myp/main.dart';
//import './textdisplay.dart';
//import './button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    // Get parameters from the previous screen:
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>; //MyClass;
    // Get title and text parameters:
    final title = routeArgs['title'].toString();
    final texttoshow = routeArgs['text'].toString();

  /*@override
  void dispose() {
   // Clean up the controller when the widget is disposed.
   myController.dispose();
   super.dispose();
}*/


    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Titolo',
          )
          ),
          const TextField(
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Descrizione',
          )
          ),
          RaisedButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage(title: "Lunardelli App")));
          },
          child: const Text("SUBMIT"),
          
          
          )
        ],
      )
    );
  }
}