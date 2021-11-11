import 'package:flutter/material.dart';
import 'package:mini_dialog/src/customize_dialog.dart';
import 'basic_dialog.dart';
import 'tools.dart';

showCustomizeDialog(
  BuildContext context,
  Widget child, {
  bool barrierDismissible = true,
}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return CustomizeDialog(
          barrierDismissible: barrierDismissible,
          child: child,
        );
      });
}

/// 显示信息提示框
showMiniAlterDialog(
  BuildContext context,
  String title,
  String message, {
  String? colorContent,
  TextStyle? titleStyle,
  bool barrierDismissible = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (ctx) {
      return BasicDialog(
        title: title,
        titleStyle: titleStyle,
        child: GestureDetector(
          onLongPress: () => clip(message),
          child: buildSearchSpan(
            message,
            colorContent ?? '',
            style: const TextStyle(height: 1.5, color: Colors.black),
          ),
        ),
      );
    },
  );
}
