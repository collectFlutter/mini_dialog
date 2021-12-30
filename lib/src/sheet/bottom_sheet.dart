import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiniBottomSheet extends StatelessWidget {
  final Widget title;
  final Color backgroundColor;
  final List<Widget> children;
  final Widget operation;
  final VoidCallback? onOk;
  final double? height;
  final EdgeInsetsGeometry padding;

  const MiniBottomSheet({
    Key? key,
    required this.title,
    this.children = const [],
    this.padding = const EdgeInsets.only(left: 5, right: 5, bottom: 10),
    this.operation = const SizedBox(height: 15),
    this.height,
    this.onOk,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      duration: const Duration(milliseconds: 100),
      child: Padding(
        padding: padding,
        child: Material(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            height: height ?? MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 5, right: 0, top: 3),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        left: 8.0,
                        child: onOk != null
                            ? CupertinoButton(
                                child: const Text(
                                  '取消',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                  ),
                                ),
                                padding: const EdgeInsets.all(5),
                                onPressed: () => Navigator.pop(context),
                              )
                            : const SizedBox(width: 20),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 45,
                        child: title,
                      ),
                      Positioned(
                        right: 0.0,
                        child: onOk != null
                            ? CupertinoButton(
                                child: const Text(
                                  '确认',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                                padding: const EdgeInsets.all(5),
                                onPressed: onOk,
                              )
                            : CupertinoButton(
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                  size: 32,
                                ),
                                padding: const EdgeInsets.all(5),
                                onPressed: () => Navigator.pop(context),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(children: children),
                    ),
                  ),
                  Container(child: operation)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
