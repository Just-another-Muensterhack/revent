import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericList<T> extends StatefulWidget {
  List<T> _list;
  String Function(T elm) _builder;

  GenericList(this._list, this._builder);

  State<GenericList> createState() => _GenericListState();
}

class _GenericListState<T> extends State<GenericList<T>> {
  List<T> _result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          T e = widget._list[index];
          String title = widget._builder(e);

          return ListTile(
            title: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(_result.contains(e) ? Icons.check : Icons.remove),
            onTap: () {
              setState(() {
                if (_result.contains(e)) {
                  _result.remove(e);
                } else {
                  _result.add(e);
                }
              });
            },
          );
        },
        itemCount: widget._list.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () => Navigator.of(context).pop(this._result),
      ),
    );
  }
}
