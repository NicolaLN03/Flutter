import 'package:flutter/material.dart';
import 'package:myp/main.dart';
import 'textfield.dart';
//import './textdisplay.dart';
//import './button.dart';

class InfoSviluppatore extends StatelessWidget {
  const InfoSviluppatore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get parameters from the previous screen:
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>; //MyClass;
    // Get title and text parameters:
    final title = routeArgs['title'].toString();
    final texttoshow = routeArgs['text'].toString();


    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextDisplay("Lo sviluppatore dell'APP è Lunardelli"),
            Icon(
            Icons.copyright,
            color: Colors.black.withOpacity(0.75),
            size: 26.0,
            ),
          ],
        )
        
      )  
    
    );
  }
}