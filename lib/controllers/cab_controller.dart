import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:parent_care/model/cab_booking.dart';

class CabBookingController extends GetxController {
  final pickupController = TextEditingController();
  final dropController = TextEditingController();

  Rx<DateTime?> selectedTime = Rx<DateTime?>(null);

  void chooseTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      final now = DateTime.now();
      selectedTime.value = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
    }
  }

  void bookCab() {
    if (pickupController.text.isEmpty ||
        dropController.text.isEmpty ||
        selectedTime.value == null) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    CabBookingModel booking = CabBookingModel(
      pickup: pickupController.text,
      drop: dropController.text,
      time: selectedTime.value!,
    );

    Get.snackbar(
      "Success",
      "Cab booked successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
