enum notification_status {
  unread,
  dismissed,
}

class Notification{
  String title;
  String body;
  DateTime created = DateTime.now();

  notification_status status = notification_status.unread;

  Notification(this.title, this.body, {this.created});

}