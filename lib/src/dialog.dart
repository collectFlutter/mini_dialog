import 'package:flutter/material.dart';
import 'package:mini_dialog/src/customize_dialog.dart';
import 'package:mini_dialog/src/input_dialog.dart';
import 'basic_dialog.dart';
import 'tools.dart';

/// 显示自定义对话框
Future<T?> showMiniCustomizeDialog<T>(
  BuildContext context,
  Widget child, {
  bool barrierDismissible = false,
}) async {
  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) {
      return CustomizeDialog(
        barrierDismissible: barrierDismissible,
        child: child,
      );
    },
  );
}

/// 确认对话框
Future<bool?> showMiniConfirmDialog(
  BuildContext context,
  String title,
  String message, {
  String keyword = '',
  Color keywordColor = Colors.pinkAccent,
  TextStyle? titleStyle,
  bool barrierDismissible = false,
  String confirmLabel = '确认',
  String cancelLabel = '取消',
}) async {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (ctx) {
      return BasicDialog(
        title: title,
        titleStyle: titleStyle,
        child: buildSearchSpan(
          message,
          keyword,
          style: const TextStyle(height: 1.5, color: Colors.black),
          searchTextColor: keywordColor,
        ),
        action1: cancelLabel,
        action1OnTap: () => Navigator.pop(context, false),
        action2: confirmLabel,
        action2OnTap: () => Navigator.pop(context, true),
      );
    },
  );
}

/// 显示提示提示框
Future<bool?> showMiniAlterDialog(
  BuildContext context,
  String title,
  String message, {
  String cancelLabel = '知道了',
  String? keyword,
  Color keywordColor = Colors.pinkAccent,
  TextStyle? titleStyle,
  bool barrierDismissible = true,
}) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (ctx) {
      return BasicDialog(
        title: title,
        titleStyle: titleStyle,
        action1: cancelLabel,
        action1Color: Theme.of(context).primaryColor,
        action1OnTap: () => Navigator.pop(context, true),
        child: GestureDetector(
          onLongPress: () => clip(message),
          child: buildSearchSpan(
            message,
            keyword ?? '',
            style: const TextStyle(height: 1.5, color: Colors.black),
            searchTextColor: keywordColor,
          ),
        ),
      );
    },
  );
}

/// 输入对话框
Future<String?> showInputDialog(
  BuildContext context,
  String title, {
  String? label,
  String? message,
  String? content,
  String? hint,
  TextInputType inputType = TextInputType.text,
  TextStyle messageTextStyle = const TextStyle(
    height: 1.2,
    color: Colors.pinkAccent,
    fontSize: 18,
  ),
  String cancelLabel = '取消',
  String confirmLabel = '确认',
  VoidCallback? onCancelCallback,
  ValueChanged<String>? onConfirmCallback,
}) async {
  return await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return InputDialog(
        title: title,
        label: label,
        content: content,
        message: message,
        hint: hint,
        inputType: inputType,
        messageTextStyle: messageTextStyle,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        onCancelCallback: onCancelCallback,
        onConfirmCallback: onConfirmCallback,
      );
    },
  );
}
