import 'package:flutter/material.dart';
import 'package:revent/models/notification.dart';

class NotificationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class _NotificationPageState extends State<NotificationPage>{

  List<NotificationModel> notifications = <NotificationModel>[];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: this.notifications
          .map(
              (NotificationModel n) {
                return ListTile(
                  title: n.,
                )
              }),
    );
  }

}