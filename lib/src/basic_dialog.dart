import 'package:flutter/material.dart';

class BasicDialog extends StatelessWidget {
  const BasicDialog({
    Key? key,
    required this.title,
    required this.child,
    this.hiddenTitle = false,
    this.titleStyle,
    this.action1,
    this.action2,
    this.onTap1,
    this.onTap2,
    this.action1Color,
    this.action2Color,
    this.actionDefaultColor = Colors.blue,
    this.childPadding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  /// 隐藏标题
  final bool hiddenTitle;
  final Widget child;
  final TextStyle? titleStyle;
  final String? action1;
  final String? action2;
  final Color? action1Color;
  final Color? action2Color;
  final Color actionDefaultColor;
  final EdgeInsets childPadding;

  @override
  Widget build(BuildContext context) {
    Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: titleStyle ??
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
    List<Widget> actions = [];
    if (action1 != null) {
      actions.add(_buildButton(
        label: action1!,
        onTap: onTap1,
        labelColor: action1Color ?? Theme.of(context).dividerColor,
      ));
    }
    if (action2 != null) {
      actions.add(_buildButton(
        label: action2!,
        onTap: onTap2,
        labelColor: action2Color ?? Theme.of(context).primaryColor,
      ));
    }
    if (actions.isEmpty) {
      actions.add(
        _buildButton(
            label: '知道了',
            labelColor: actionDefaultColor,
            onTap: () => Navigator.of(context).pop()),
      );
    }
    var body = Material(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 18),
          dialogTitle,
          Flexible(child: Padding(padding: childPadding, child: child)),
          Divider(color: Colors.grey[200], height: 0.8),
          Row(children: actions),
        ],
      ),
    );
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.only(left: 50, right: 50, top: 25, bottom: 25),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(child: body),
      ),
    );
  }
}

Widget _buildButton({
  required String label,
  Color? labelColor,
  VoidCallback? onTap,
  double? labelSize,
}) {
  return Expanded(
      child: SizedBox(
    height: 48,
    child: MaterialButton(
      child: Text(
        label,
        style: TextStyle(
          color: labelColor,
          fontSize: labelSize,
        ),
      ),
      onPressed: onTap,
    ),
  ));
}
