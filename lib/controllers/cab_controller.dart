import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_care/model/cab_booking.dart';

class CabBookingController extends GetxController {
  final pickupController = TextEditingController();
  final dropController = TextEditingController();

  // Using DateTime for time
  Rx<DateTime?> selectedTime = Rx<DateTime?>(null);

  /// Choose Time
  Future<void> chooseTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      selectedTime.value = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }

  /// Save Cab Booking to Firebase
  Future<void> bookCab() async {
    if (pickupController.text.isEmpty ||
        dropController.text.isEmpty ||
        selectedTime.value == null) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    // Create model object
    CabBookingModel booking = CabBookingModel(
      pickup: pickupController.text.trim(),
      drop: dropController.text.trim(),
      time: selectedTime.value!,
    );

    try {
      // Save to Firebase
      await FirebaseFirestore.instance.collection("cab_bookings").add({
        "pickup": booking.pickup,
        "drop": booking.drop,
        "time": booking.time.toIso8601String(),
        "createdAt": Timestamp.now(),
      });

      // Success Dialog
      Get.defaultDialog(
        title: "Cab Booked",
        middleText:
            "Pickup: ${booking.pickup}\nDrop: ${booking.drop}\nTime: ${booking.time.hour.toString().padLeft(2, '0')}:${booking.time.minute.toString().padLeft(2, '0')}\n\nYour cab has been booked successfully!",
      );

      // Clear fields
      pickupController.clear();
      dropController.clear();
      selectedTime.value = null;

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}

