import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_dialog/src/dialog/basic_dialog.dart';

import '../tools.dart';

class MiniInputDialog extends StatelessWidget {
  MiniInputDialog({
    Key? key,
    required this.title,
    this.message,
    this.label,
    this.content,
    this.hint,
    this.inputType = TextInputType.text,
    this.messageTextStyle = const TextStyle(
      height: 1.2,
      color: Colors.pinkAccent,
      fontSize: 16,
    ),
    this.cancelLabel = '取消',
    this.confirmLabel = '确认',
    this.onCancelCallback,
    this.onConfirmCallback,
  }) : super(key: key);
  final String? message;
  final TextStyle messageTextStyle;
  final String title;
  final String? label;
  final String? content;
  final String? hint;
  final String cancelLabel;
  final String confirmLabel;
  final TextInputType inputType;
  final VoidCallback? onCancelCallback;
  final ValueChanged<String>? onConfirmCallback;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = content ?? '';
    return BasicDialog(
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message ?? '',
            textAlign: TextAlign.left,
            style: messageTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              controller: _controller,
              keyboardType: inputType,
              inputFormatters: _getInputFormatter(inputType),
              decoration: InputDecoration(
                labelText: label ?? "",
                hintText: hint ?? "请输入${label ?? ''}",
              ),
            ),
          ),
        ],
      ),
      action1: cancelLabel,
      action1OnTap: () {
        if (onCancelCallback != null) {
          onCancelCallback!();
        } else {
          Navigator.pop(context);
        }
      },
      action2: confirmLabel,
      action2OnTap: () {
        if (onConfirmCallback != null) {
          onConfirmCallback!(_controller.text);
        } else {
          Navigator.pop(context, _controller.text);
        }
      },
    );
  }

  _getInputFormatter(TextInputType keyboardType) {
    if (keyboardType == const TextInputType.numberWithOptions(decimal: true)) {
      return [UsNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number ||
        keyboardType == TextInputType.phone) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
