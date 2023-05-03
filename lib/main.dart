import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neuro_planner/ui/widgets/toggle_button.dart';
import 'package:vibration/vibration.dart';

import 'examination_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff22577a),
          onPrimary: Colors.white,
          secondary: Colors.lightGreen,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.blue,
          surface: Colors.white70,
          onSurface: Colors.black,
        ),
      ),
      home: const MyHomePage(title: 'Vibration Trigger App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final int vibDuration = 30000;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isVibrating = false;

  void _vibrate() {
    if (_isVibrating) {
      Vibration.cancel();
      setState(() {
        _isVibrating = false;
      });
    } else {
      setState(() {
        _isVibrating = true;
      });
      Vibration.vibrate(duration: widget.vibDuration, amplitude: 255);
      Future.delayed(Duration(milliseconds: widget.vibDuration), () {
        setState(() {
          _isVibrating = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ToggleButton(
                options: <String>['YES', 'NO', 'MAYBE'], onPressed: () {}),
            Text(
              'Press the button below to have phone vibrate for ${widget.vibDuration / 1000} seconds',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const Padding(padding: kMaterialListPadding),
            FloatingActionButton.large(
              onPressed: _vibrate,
              tooltip: (_isVibrating) ? "Stop Vibration" : "Start Vibration",
              child: Icon((_isVibrating) ? Icons.pause : Icons.play_arrow),
            ),
            ElevatedButton(
              child: Text('Begin new examination'),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                      builder: (context) => ExaminationPage())),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
