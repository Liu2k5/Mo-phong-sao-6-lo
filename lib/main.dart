import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mo phong sao 6 lo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Mo phong sao 6 lo'),
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Center(child: FluteBoard()),
      ),
    );
  }
}

class FluteBoard extends StatefulWidget {
  const FluteBoard({super.key});

  @override
  State<FluteBoard> createState() {
    return FluteBoardState();
  }
}

class FluteBoardState extends State<FluteBoard> {
  bool button1 = false;
  bool button2 = false;
  bool button3 = false;
  bool button4 = false;
  bool button5 = false;
  bool button6 = false;

  void toggleButton(int index) {
    setState(() {
      switch (index) {
        case 1:
          button1 = !button1;
          break;
        case 2:
          button2 = !button2;
          break;
        case 3:
          button3 = !button3;
          break;
        case 4:
          button4 = !button4;
          break;
        case 5:
          button5 = !button5;
          break;
        case 6:
          button6 = !button6;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => toggleButton(1),
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(100, 100)),),
          child: Text('1: ${button1 ? 'ON' : 'OFF'}'),
        ),
        TextButton(
          onPressed: () => toggleButton(2),
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(100, 100)),),
          child: Text('2: ${button2 ? 'ON' : 'OFF'}'),
        ),
        TextButton(
          onPressed: () => toggleButton(3),
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(100, 100)),),
          child: Text('3: ${button3 ? 'ON' : 'OFF'}'),
        ),
        TextButton(
          onPressed: () => toggleButton(4),
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(100, 100)),),
          child: Text('4: ${button4 ? 'ON' : 'OFF'}'),
        ),
        TextButton(
          onPressed: () => toggleButton(5),
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(100, 100)),),
          child: Text('5: ${button5 ? 'ON' : 'OFF'}'),
        ),
        TextButton(
          onPressed: () => toggleButton(6),
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(100, 100)),),
          child: Text('6: ${button6 ? 'ON' : 'OFF'}'),
        ),
      ],
    );
  }
}
