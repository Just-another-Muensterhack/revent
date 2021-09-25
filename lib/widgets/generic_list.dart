import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericList<T> extends StatefulWidget {
  List<T> _list;
  String Function<T>(T elm) builder;

  GenericList(this._list);

  State<GenericList> createState() => _GenericListState();
}

class _GenericListState<T> extends State<GenericList<T>> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      T e = widget._list[index];
      String title = widget.builder(e);
      return ListTile(title: Text(title));
    }, itemCount: widget._list.length);
  }
}
