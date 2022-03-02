import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get parameters from the previous screen:
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    
    final correct = routeArgs['correct'];
    final tot = routeArgs['tot'];
    var incorrect = tot! - correct!;
    var percent = correct / tot *100;

    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz terminato!'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Text("Risposte corrette: $correct\n Risposte errate:$incorrect \n Percentuale di correttezza: $percent %"),
          ],
        ));
  }
}