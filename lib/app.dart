import 'dart:async';
import 'package:flutter/material.dart';
import 'common/common.dart';
import 'core/core.dart';

void main() async {
  runZonedGuarded(
    () {
      debugPrint(Env.name);
      runApp(const MyApp());
    },
    (error, stackTrace) {
      debugPrint('Caught error in zone: $error');
      debugPrint('$stackTrace');
      debugPrint(Env.name);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/736x/e3/88/d0/e388d043853a9b630eff7a240d919fe5.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GlassContainer(
            width: 300,
            height: 300,
            child: Center(child: Text(_counter.toString())),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
