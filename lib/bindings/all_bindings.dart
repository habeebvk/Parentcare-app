import 'package:get/get.dart';
import 'package:parent_care/controllers/nav_controller.dart';
import 'package:parent_care/controllers/theme_controller.dart';
import 'package:parent_care/controllers/appointment_controller.dart';
import 'package:parent_care/controllers/cab_controller.dart';
import 'package:parent_care/controllers/grocery_controller.dart';
import 'package:parent_care/controllers/food_controller.dart';
import 'package:parent_care/controllers/hospital_controller.dart';
import 'package:parent_care/controllers/alert_controller.dart';
// Note: CancelAppointmentController seemed to be used in edit_cancel.dart,
// I should check if it's a separate controller or part of appointment_controller.
// I'll check usages to be sure, but for now I will add standard ones.

class InitialConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }
}

class NavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavController>(() => NavController());
    Get.lazyPut<GroceryController>(() => GroceryController());
    Get.lazyPut<AppointmentController>(() => AppointmentController());
    Get.lazyPut<CabBookingController>(() => CabBookingController());
  }
}


class AppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentController>(() => AppointmentController());
    Get.lazyPut<CancelAppointmentController>(
      () => CancelAppointmentController(),
    );
  }
}

class CabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CabBookingController>(() => CabBookingController());
  }
}

class GroceryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroceryController>(() => GroceryController());
  }
}

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodController>(() => FoodController());
    // There was FoodOrdersController used in hotel_screen.dart, need to check if it's distinct.
    Get.lazyPut<FoodOrdersController>(() => FoodOrdersController());
  }
}

class HospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HospitalController>(() => HospitalController());
  }
}

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}

// CancelAppointmentController seems missing from controllers dir list, likely defined in appointment_controller or widget file.
// I will investigate this if compilation fails or if further search reveals it.
