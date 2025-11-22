class AppNotification {
  String title;
  String message;
  String time;
  bool isRead;

  AppNotification({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}
