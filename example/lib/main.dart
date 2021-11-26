import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_dialog/mini_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  List<Item> items = List.generate(
    100,
    (index) => Item(
      'JsonYe${index + 1}-jsonye',
      height: Random().nextDouble() * 100,
      sex: Random().nextBool(),
    ),
  );

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
          "showMiniAlterDialog2": showDialog3,
          "showMiniInputDialog": showInputDialogDemo,
          "showMiniConfirmDialog": showConfirmDialogDemo,
          "showLoadingDialog": showLoadingDialogDemo,
          "showSuccessDialog": showSuccessDialogDemo,
          "showFailDialog": showFailDialogDemo,
          "showMiniListPopup": showMiniListPopupDemo,
          "showMiniSearchListPopup": showMiniSearchListPopupDemo,
        },
      );
    if (mounted) setState(() {});
  }

  void showMiniListPopupDemo() async {
    var index = await showMiniListPopup<Item>(
      context,
      '选择列表',
      items,
      toLabel: (i) => i.name,
    );
    debugPrint(index?.toString());
  }

  void showMiniSearchListPopupDemo() async {
    var index = await showMiniSearchListPopup<Item>(
      context,
      items,
      hintText: '搜索列表',
      toLabel: (i) => i.name,
      contains: (Item object, String content) =>
          object.name.toLowerCase().contains(content.toLowerCase()),
    );
    debugPrint(index?.toString());
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
      keyword: '消息',
    );
  }

  void showDialog3() {
    showMiniAlterDialog(
      context,
      '提示',
      '这是一个消息对话框' * 8,
      keyword: '消息',
      barrierDismissible: false,
    );
  }

  void showInputDialogDemo() async {
    var data = await showMiniInputDialog(
      context,
      '输入框',
      message: '你的身高决定了你的衣服尺寸！',
      content: '10',
      hint: '请输入身高',
      inputType: const TextInputType.numberWithOptions(decimal: true),
    );
    debugPrint(data);
  }

  void showConfirmDialogDemo() async {
    var data = await showMiniConfirmDialog(
      context,
      '提示',
      '你的身高决定了你的衣服尺寸！',
      keyword: '身高',
      confirmColor: Colors.red,
    );
    debugPrint(data?.toString());
  }

  void showLoadingDialogDemo() async {
    showMiniLoadingDialog(context);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
      },
    );
  }

  void showSuccessDialogDemo() async {
    showMiniIconDialog(context, label: '支付成功');
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
      },
    );
  }

  void showFailDialogDemo() async {
    showMiniIconDialog(
      context,
      label: '支付失败',
      icon: Icon(Icons.close, color: Colors.red[600], size: 44),
      // labelColor: Colors.red[600],
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
      },
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

class Item {
  late String name;
  double? height;
  bool? sex;

  Item(this.name, {this.height, this.sex});

  @override
  String toString() => name;
}
