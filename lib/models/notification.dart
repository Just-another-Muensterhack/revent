enum notification_status {
  unread,
  dismissed,
}

class NotificationModel{
  String title;
  String body;
  DateTime created = DateTime.now();

  notification_status status = notification_status.unread;

  NotificationModel(this.title, this.body, {this.created, this.status});

}