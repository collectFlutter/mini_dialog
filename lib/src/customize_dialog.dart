import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 自定义对话框
class CustomizeDialog extends Dialog {
  /// The `barrierDismissible` argument is used to indicate whether tapping on the
  /// barrier will dismiss the dialog. It is `true` by default and can not be `null`.
  final bool barrierDismissible;

  const CustomizeDialog({
    Key? key,
    Widget? child,
    this.barrierDismissible = true,
  }) : super(key: key, child: child);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.black45,
      child: GestureDetector(
        onTap: barrierDismissible ? () => Navigator.pop(context) : null,
        child: Container(
          color: Colors.black45,
          child: child,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
