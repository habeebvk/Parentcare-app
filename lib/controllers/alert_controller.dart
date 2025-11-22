import 'package:get/get.dart';
import 'package:parent_care/model/slert_model.dart';

class NotificationController extends GetxController {
  RxList<AppNotification> notifications = <AppNotification>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Load some initial notifications
    notifications.addAll([
      AppNotification(
          title: "Medicine Reminder",
          message: "Take BP tablet at 5 PM",
          time: "2 min ago"),
      AppNotification(
          title: "Appointment Alert",
          message: "Hospital appointment Tomorrow at 10 AM",
          time: "1 hour ago"),
      AppNotification(
          title: "Cab Arrival",
          message: "Your cab is arriving in 5 minutes",
          time: "Today"),
    ]);
  }

  void markAsRead(int index) {
    notifications[index].isRead = true;
    notifications.refresh();
  }

  void deleteNotification(int index) {
    notifications.removeAt(index);
  }

  void clearAll() {
    notifications.clear();
  }
}
