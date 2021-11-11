import 'package:flutter/material.dart';
import 'package:mini_dialog/mini_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, Function> fun = {};

  @override
  void initState() {
    update();
    super.initState();
  }

  void update() {
    fun
      ..clear()
      ..addAll(
        {
          "AlertDialog": showDialog1,
          "showMiniAlterDialog": showDialog2,
          "showCustomizeDialog": showDialog3
        },
      );
    if (mounted) setState(() {});
  }

  void showDialog1() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('提示'),
            content: const Text("这是一个消息对话框"),
            actions: [
              TextButton(
                onPressed: () {
                  debugPrint('这是一个消息对话框');
                  Navigator.of(ctx).pop();
                },
                child: const Text("知道了"),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
            actionsOverflowButtonSpacing: 10,
          );
        });
  }

  void showDialog2() {
    showMiniAlterDialog(
      context,
      '提示',
      '这是一个消息对话框',
      colorContent: '消息',
    );
  }

  void showDialog3() {
    showMiniAlterDialog(
      context,
      '提示',
      '这是一个消息对话框' * 8,
      colorContent: '消息',
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: fun.keys
              .map(
                (e) => TextButton(onPressed: () => fun[e]!(), child: Text(e)),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: update,
        tooltip: 'Increment',
        child: const Icon(Icons.update),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
