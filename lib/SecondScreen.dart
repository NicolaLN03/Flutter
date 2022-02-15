//Lunardelli Nicola 5^B IA

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/dom.dart' as htmlParser;
import 'package:quiz/question.dart';
import 'package:quiz/widgets/textdisplay.dart';
import 'package:quiz/main.dart';
import 'widgets/button.dart';

Widget _buildTitle() { //widget con titolo della schermata
    return Center(
      child: SizedBox(
        child: Column(
          children: const <Widget>[
            Text(
              "SCHERMATA RISULTATI",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
}

class SecondScreen extends StatefulWidget {
  int punti;
  int errate;
  int corrette;
  SecondScreen({required this.punti, required this.errate, required this.corrette});

  @override
  State<StatefulWidget> createState() {
    return SecondScreenState();
}
}

class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    int punti = widget.punti;
    int errate = widget.errate;
    int corrette = widget.corrette;

    return Scaffold(
        appBar: AppBar( //TITOLO
        title: _buildTitle(),
        backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            TextDisplay(
              myText: "PUNTI TOTALI: $punti",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: Colors.white,
            ),
            TextDisplay(
              myText: "RISPOSTE CORRETTE : $corrette",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: Colors.white,
            ),
            TextDisplay(
              myText: "RISPOSTE ERRATE : $errate",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: Colors.white,
            ),
            const SizedBox(height: 30),
            Button(
              selectHandler: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage(title: 'Lunardelli App')));
              },
              buttonText : 'NUOVO QUIZ',
              color_text: Colors.black,
              background_color: Colors.amber,
            )        
          ],
        ),      
    );
    
  }
}