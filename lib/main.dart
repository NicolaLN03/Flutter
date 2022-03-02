//Lunardelli Nicola 5^B IA 13-01-20222
import 'package:flutter/material.dart';
import 'package:myp/infoLista.dart';
import 'SecondScreen.dart';
import 'InfoSviluppatore.dart';
import 'todo.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
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
      // Define here the routes for the other app screens:
      routes: {
        '/infoLista' : (ctx) => InfoLista(),
        '/secondscreen' : (ctx) => SecondScreen(),
        '/infoSviluppatore' : (ctx) => InfoSviluppatore(),
      } ,
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  // Simil overloading:
  MyHomePage.myconstr({required this.title});
  // final boh = MyHomePage.myconstr(title: 'Pippo',);
  final String title;
  final todos = 0;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  /*
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState(); 
  } */
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  final List<Todo> todos = [];
  
void viewSecondScreen(BuildContext context) async{

  final Todo newTodo = await Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => const SecondScreen())
  );

  setState(() {
    todos.add(newTodo);
    final snackbar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(newTodo.title.toString() + " aggiunto"),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () =>
        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
  });
}

void _deleteItem(Todo t){
  setState(() {
    todos.remove(t);
  });
  final snackbar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(t.title.toString() + " eliminato"),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () =>
        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(padding: EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/infoSviluppatore'
                );
              },
              child: Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.75),
                size: 26.0,
             	),
            )
            )
          ],
        ),
        body: Center(
          child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            onTap: () => showDialog<String>(
              context: context, 
              builder: (BuildContext context) => 
              AlertDialog(
                title: Text(todos[index].title),
                content: Text(todos[index].description),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                     child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () {
                      _deleteItem(todos[index]);
                      Navigator.pop(context, 'Delete');
                    },
                    child: const Text('Delete'),
                  ),
                ],
              )
              )
            /*{
                Navigator.of(context).pushNamed(
                  '/infoLista',
                  arguments: {
                  'todo': todos[index],
                });
              },*/
    );
  },
  ),  
  ),
  floatingActionButton: FloatingActionButton (
    backgroundColor: Colors.amber,
    onPressed: (){ 
      viewSecondScreen(context);
    },
    child: const Text(
                "NEW LIST",
                textAlign: TextAlign.center,
                ),
  )
  );
  }
}