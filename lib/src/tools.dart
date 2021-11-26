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
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
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
Widget buildSearchSpan(
  String content,
  String searchText, {
  Color searchTextColor = Colors.red,
  TextStyle style = const TextStyle(color: Colors.black, fontSize: 16),
  bool insensitiveCase = true,
}) {
  String _content = insensitiveCase ? content.toLowerCase() : content;
  String _searchText = insensitiveCase ? searchText.toLowerCase() : searchText;

  List<TextSpan> spans = [];
  int _cLength = _content.length;
  int _sLength = _searchText.length;
  int _start = 0;
  for (int i = 0; _sLength > 0 && i <= _cLength - _sLength; i++) {
    if (_content.substring(i, i + _sLength) == _searchText) {
      spans.addAll([
        TextSpan(text: content.substring(_start, i), style: style),
        TextSpan(
            text: content.substring(i, _sLength + i),
            style: style.copyWith(color: searchTextColor))
      ]);
      _start = i + _sLength;
      i = _start - 1;
    }
  }
  if (_start != _cLength) {
    spans.add(TextSpan(text: content.substring(_start), style: style));
  }
  return RichText(text: TextSpan(style: style, children: spans));
}

/// 复制到剪切板
void clip(String value) => Clipboard.setData(ClipboardData(text: value));

typedef ToString<T> = String Function(T model);

typedef BuildCheckChild<T> = Widget Function(BuildContext context, T t,
    [String? highlight]);

/// 对象的模糊查找
typedef Contains<T> = bool Function(T object, String content);
