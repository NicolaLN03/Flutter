//Lunardelli Nicola 5^B IA
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/dom.dart' as htmlParser;
import 'package:quiz/question.dart';
import 'package:quiz/SecondScreen.dart';
import 'package:quiz/widgets/textdisplay.dart';
import 'widgets/button.dart';

void main() {
  runApp(MyApp());
}
Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lunardelli Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lunardelli App'),
    );
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Lunardelli App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  List<Question>? _questions = null; // questions data structure
  List<String>? _answers = null; // answers list
  var _index = 0;
  int punti = 0;
  int errate = 0;
  int corrette = 0;
  int countDomande = 0;

  String url_string = "https://opentdb.com/api.php?amount=10";

  void resetPoints()
  {
    punti = 0;
    countDomande = 0;
    errate = 0;
    corrette = 0;
  }

  void goToReplayScreen()
  {
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return SecondScreen(
          punti: punti, corrette: corrette, errate: errate
        );
      }      
    ));
  }

  void next() {
    countDomande ++;
    print(countDomande);
    /*if(countDomande>=10)
    {
      goToReplayScreen();
      resetPoints();
    }
    else
    {*/
      if(_questions == null || _questions!.length == 0)
        return;
      setState(() {
      if(_index < _questions!.length - 1)
        _index++;
      else
        _index = 0;
      // update answers:
      _answers = List.from(_questions![_index].incorrect);
      _answers!.add(_questions![_index].correct);
      _answers!.shuffle();
      });
    //}
  }

  void doGet() {  
    resetPoints(); //resetta il numero di domande fatte ed i punti
    http.get(Uri.parse(url_string)).then( (response) {
    var jsondata = json.decode(response.body);
    var questions = jsondata['results'];

      // Qui inserisci il codice opportuno per gestire lo stato:
      setState(() {
        _questions = questions.map<Question>((val) =>  Question.fromJson(val)).toList();
        // initialize answer list:
        _answers = List.from(_questions![_index].incorrect);
        _answers!.add(_questions![_index].correct);
        _answers!.shuffle();        
      });
      
      // debug (esempi di stampa dei dati contenuti nel json)
      print(htmlParser.DocumentFragment.html("Question: "+questions[0]['question']).text.toString());
      print("Correct answer is "+questions[0]['correct_answer']);
      print("Category: "+questions[0]['category']);

    });
  }

  void _checkAnswer(String ans) {
    String msg = "Hai sbagliato, la risposta corretta era: "+_questions![_index].correct;
    String bad_good_boy = "BAD BOY";
    if(ans == _questions![_index].correct)
    {
      msg = "Congratulazioni! Risposta corretta ";
      bad_good_boy = "GOOD BOY";
      punti ++;
      corrette ++;
    }
    else
    {
      punti --;
      errate ++;
    }
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Risultati"),
            content: Text(msg),
            actions: <Widget> [
              FlatButton(
                autofocus: true,
                child: Text('OK'),
                onPressed: () {next(); Navigator.of(ctx).pop(true);}, //Navigator.of(ctx).pop(true); 
              ) ,
            ] ,
          )
       );
  }

   List<Widget> _buildAnswerButtons(List<String> ans) {

    return ans.map<Button>((e) => Button(selectHandler: () => _checkAnswer(e), buttonText: e, background_color: Colors.lightBlue, color_text: Colors.black,)).toList();
  }

  // Load data from Open Trivia DB at the beginning:
  void initState() {
    doGet();
    //assert(_debugLifecycleState == _StateLifecycle.created);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            TextDisplay(
              myText: (_questions != null && _questions![0] != null) ? _questions![_index].question: 'none',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: Colors.white
            ),
            const SizedBox(height: 10),
            if(_answers!= null && _buildAnswerButtons(_answers!)!=null) 
              ... _buildAnswerButtons(_answers!)
            else 
              const CircularProgressIndicator(), //Text('Load Quiz!'),
            
            const SizedBox(height: 20),
            //Button(selectHandler: next, buttonText : 'NEXT', background_color: Colors.amber, color_text: Colors.black),
            Button(selectHandler: goToReplayScreen, buttonText : 'TERMINA QUIZ', background_color: Colors.amber, color_text: Colors.black),
          ],
        ),      
    );
  }
}
