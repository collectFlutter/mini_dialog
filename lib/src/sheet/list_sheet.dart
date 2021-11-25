import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet.dart';
import '../tools.dart';

class MiniListBottomSheet<T> extends StatelessWidget {
  final Widget title;
  final double titleHeight;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  /// 数据源
  final List<T> dataSource;

  /// 对象显示标签
  final ToString<T>? toLabel;

  /// 构建列表的View
  final BuildCheckChild<T>? buildItem;

  /// 点击选项
  final ValueChanged<T>? onItemClick;

  final Widget operation;

  const MiniListBottomSheet(
      {Key? key,
      required this.title,
      this.titleHeight = 60,
      this.backgroundColor = Colors.white,
      this.padding = const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      this.dataSource = const [],
      this.toLabel,
      this.buildItem,
      this.onItemClick,
      this.operation = const SizedBox(
        height: 10,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height * 4 / 9.0;
    if (dataSource.length < 6) {
      _height = titleHeight + dataSource.length * 60 + 10;
    }
    return MiniBottomSheet(
      title: Container(
        padding: const EdgeInsets.only(right: 45, left: 10, top: 4),
        height: titleHeight + 8.0,
        child: title,
      ),
      padding: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
      height: _height,
      children: dataSource
          .map((item) => ListTile(
                onTap: () {
                  if (onItemClick != null) {
                    onItemClick!(item);
                  } else {
                    Navigator.pop(context, dataSource.indexOf(item));
                  }
                },
                title: buildItem != null
                    ? buildItem!(context, item)
                    : Text(
                        toLabel != null ? toLabel!(item) : item.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ))
          .toList(),
      operation: operation,
    );
  }
}

class MiniSearchListBottomSheet<T> extends StatefulWidget {
  final String? hintText;
  final double titleHeight;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  /// 数据源
  final List<T> dataSource;

  /// 对象的模糊查询
  final Contains<T> contains;

  /// 对象显示标签
  final ToString<T>? toLabel;

  /// 构建列表的View
  final BuildCheckChild<T>? buildItem;
  final Widget operation;

  const MiniSearchListBottomSheet({
    Key? key,
    required this.contains,
    this.hintText,
    this.titleHeight = 60,
    this.backgroundColor = Colors.white,
    this.dataSource = const [],
    this.padding = const EdgeInsets.only(left: 5, right: 5, bottom: 10),
    this.buildItem,
    this.toLabel,
    this.operation = const SizedBox(
      height: 15,
    ),
  }) : super(key: key);

  @override
  _MiniSearchListBottomSheetState<T> createState() =>
      _MiniSearchListBottomSheetState<T>();
}

class _MiniSearchListBottomSheetState<T>
    extends State<MiniSearchListBottomSheet<T>> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKey = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchKey = _searchController.text;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<T> _list = widget.dataSource;
    if (_searchKey.isNotEmpty) {
      _list = _list
          .where((element) => widget.contains(element, _searchKey))
          .toList();
    }
    return MiniListBottomSheet<T>(
      title: _buildSearchWidget(),
      titleHeight: widget.titleHeight,
      backgroundColor: widget.backgroundColor,
      padding: widget.padding,
      dataSource: _list,
      toLabel: widget.toLabel,
      buildItem: widget.buildItem,
      onItemClick: (item) => Navigator.pop(
        context,
        widget.dataSource.indexOf(item),
      ),
      operation: widget.operation,
    );
  }

  Widget _buildSearchWidget() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.only(bottom: 6),
      child: TextField(
        autofocus: false,
        controller: _searchController,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: widget.hintText ?? '快速搜索',
          counterText: '',
          icon: const Padding(padding: EdgeInsets.zero),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).backgroundColor,
              width: 0.1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).backgroundColor,
              width: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}
