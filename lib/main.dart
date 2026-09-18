import 'package:flutter/material.dart';
import 'package:mophongsao6lo/flute_board.dart';
import 'package:mophongsao6lo/tone_engine.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // bắt buộc khi gọi plugin trước runApp
  try {
    await ToneEngine.instance.init();
  } catch (e, s) {
    debugPrint('Khoi dong audio that bai: $e\n$s');
  }
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

