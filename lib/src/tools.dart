import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 只允许输入小数
class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue Value) {
    String value = Value.text;
    int selectionIndex = Value.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
        value != defaultDouble.toString() &&
        strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/// 创建搜索内容
Widget buildSearchSpan(String content, String searchText,
    {Color searchTextColor = Colors.red,
    TextStyle style = const TextStyle(color: Colors.black)}) {
  int startIndex = content.indexOf(searchText);
  int endIndex = -1;
  if (startIndex > -1) {
    endIndex = startIndex + searchText.length;
    return RichText(
        text: TextSpan(
            text: content.substring(0, startIndex),
            style: style,
            children: [
          TextSpan(
              //获取剩下的字符串，并让它变成灰色
              text: searchText,
              style: style.copyWith(color: searchTextColor)),
          TextSpan(
              //获取剩下的字符串，并让它变成灰色
              text: content.substring(endIndex),
              style: style)
        ]));
  } else {
    return Text(content, maxLines: null, style: style);
  }
}

/// 复制到剪切板
void clip(String value) => Clipboard.setData(ClipboardData(text: value));
