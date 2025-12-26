import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_care/model/cab_booking.dart';
import 'package:parent_care/services/api_service.dart';

class CabBookingController extends GetxController {
  // -------- Text Controllers --------
  final nameController = TextEditingController();
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  final timeController = TextEditingController();

  final nameFocus = FocusNode();
  final pickupFocus = FocusNode();
  final dropFocus = FocusNode();
  final timeFocus = FocusNode();

  // -------- Location Coordinates --------
  double? pickupLat;
  double? pickupLng;
  double? dropLat;
  double? dropLng;

  // -------- Selected Time --------
  Rx<DateTime?> selectedTime = Rx<DateTime?>(null);
  RxList<CabBookingModel> pendingCabs = <CabBookingModel>[].obs;
  RxBool isLoading = false.obs;

    @override
  void onInit() {
    super.onInit();
    fetchPendingCabs();
  }
  /// Pick Time
  Future<void> chooseTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      selectedTime.value = dateTime;
      timeController.text =
          "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
    }
  }

  /// Submit Booking
  Future<void> submitBooking() async {
    if (nameController.text.isEmpty ||
        pickupController.text.isEmpty ||
        dropController.text.isEmpty ||
        selectedTime.value == null) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

final booking = CabBookingModel(
  id: "",
  name: nameController.text.trim(),
  pickup: pickupController.text.trim(),
  drop: dropController.text.trim(),
  pickupLat: pickupLat,
  pickupLng: pickupLng,
  dropLat: dropLat,
  dropLng: dropLng,
  time: selectedTime.value!,
  status: "pending",
);


    final success = await ApiService.bookCab(booking);

    if (success) {
      Get.snackbar("Success", "Cab booked successfully");
      clearFields();
    } else {
      Get.snackbar("Error", "Booking failed");
    }
  }

    Future<void> fetchPendingCabs() async {
    isLoading.value = true;
    pendingCabs.value = await ApiService.getPendingCabs();
    isLoading.value = false;
  }
 
   Future<void> approve(String id) async {
    if (await ApiService.approveCab(id)) {
      fetchPendingCabs();
      Get.snackbar("Success", "Cab approved");
    } else {
      Get.snackbar("Error", "Failed to approve");
    }
  }

  Future<void> reject(String id) async {
    if (await ApiService.rejectCab(id)) {
      fetchPendingCabs();
      Get.snackbar("Success", "Cab rejected");
    } else {
      Get.snackbar("Error", "Failed to reject");
    }
  }
  
  void clearFields() {
    nameController.clear();
    pickupController.clear();
    dropController.clear();
    timeController.clear();
    selectedTime.value = null;
  }

  @override
  void onClose() {
    nameController.dispose();
    pickupController.dispose();
    dropController.dispose();
    timeController.dispose();
    nameFocus.dispose();
    pickupFocus.dispose();
    dropFocus.dispose();
    timeFocus.dispose();
    super.onClose();
  }
}

