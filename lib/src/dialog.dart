import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mini_dialog/src/dialog/customize_dialog.dart';
import 'package:mini_dialog/src/dialog/input_dialog.dart';
import 'dialog/basic_dialog.dart';
import 'sheet/bottom_sheet.dart';
import 'sheet/list_sheet.dart';
import 'tools.dart';

/// 显示自定义对话框
Future<T?> showMiniCustomizeDialog<T>(
  BuildContext context, {
  required Widget child,
  bool barrierDismissible = false,
}) async {
  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) {
      return MiniCustomizeDialog(
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
  Color cancelColor = Colors.grey,
  Color confirmColor = Colors.blue,
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
        action1Color: cancelColor,
        action1OnTap: () => Navigator.pop(context, false),
        action2: confirmLabel,
        action2Color: confirmColor,
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
Future<String?> showMiniInputDialog(
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
      return MiniInputDialog(
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

showMiniIconDialog(
  BuildContext context, {
  String? label,
  Widget icon = const Icon(Icons.check, color: Colors.green, size: 44),
  Color? labelColor = Colors.black54,
}) {
  showMiniCustomizeDialog(
    context,
    child: Material(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white70,
      child: SizedBox(
        width: 120,
        height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            if (label != null) ...{
              Text(
                label,
                style: TextStyle(color: labelColor),
              ),
            }
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

showMiniLoadingDialog(BuildContext context, {String? label}) {
  showMiniIconDialog(context,
      icon: const CupertinoActivityIndicator(radius: 20),
      labelColor: Colors.grey[700]);
}

Future<T?> showMiniBottomPopup<T>(
  BuildContext context,
  String title,
  List<Widget> children, {
  double? height,
  Color backgroundColor = Colors.white,
  Widget operation = const SizedBox(height: 15),
  VoidCallback? onOk,
  EdgeInsetsGeometry padding =
      const EdgeInsets.only(left: 5, right: 5, bottom: 10),
}) async {
  return await showCupertinoModalPopup<T>(
      context: context,
      builder: (ctx) {
        return MiniBottomSheet(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          height: height,
          children: children,
          padding: padding,
          operation: operation,
          onOk: onOk,
          backgroundColor: backgroundColor,
        );
      });
}

Future<int?> showMiniListPopup<T>(
  BuildContext context,
  String title,
  List<T> dataSource, {
  double titleHeight = 60,
  ToString<T>? toLabel,
  BuildCheckChild<T>? buildItem,
  Color backgroundColor = Colors.white,
  Widget operation = const SizedBox(height: 15),
  EdgeInsetsGeometry padding =
      const EdgeInsets.only(left: 5, right: 5, bottom: 10),
}) async {
  return await showCupertinoModalPopup<int>(
      context: context,
      builder: (ctx) {
        return MiniListBottomSheet<T>(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          backgroundColor: backgroundColor,
          padding: padding,
          titleHeight: titleHeight,
          dataSource: dataSource,
          buildItem: buildItem,
          toLabel: toLabel,
          operation: operation,
        );
      });
}

Future<int?> showMiniSearchListPopup<T>(
  BuildContext context,
  List<T> dataSource, {
  required Contains<T> contains,
  String? hintText,
  double titleHeight = 60,
  ToString<T>? toLabel,
  BuildCheckChild<T>? buildItem,
  Color backgroundColor = Colors.white,
  Widget operation = const SizedBox(height: 15),
  EdgeInsetsGeometry padding =
      const EdgeInsets.only(left: 5, right: 5, bottom: 10),
}) async {
  return await showCupertinoModalPopup<int>(
      context: context,
      builder: (ctx) {
        return MiniSearchListBottomSheet<T>(
          hintText: hintText,
          contains: contains,
          backgroundColor: backgroundColor,
          padding: padding,
          titleHeight: titleHeight,
          dataSource: dataSource,
          buildItem: buildItem,
          toLabel: toLabel,
          operation: operation,
        );
      });
}
