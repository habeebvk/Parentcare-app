import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_care/model/appointment_model.dart';
import 'package:parent_care/model/hospital_model.dart';
import 'package:parent_care/services/api_service.dart';

// Hospital model
class Hospital {
  final String id;
  final String name;
  final String? address;

  Hospital({
    required this.id,
    required this.name,
    this.address,
  });
}


class AppointmentController extends GetxController {
  TextEditingController nameController = TextEditingController();
  // ---------------- HOSPITAL ----------------
  RxList<Hospital> hospitals = <Hospital>[].obs;
  Rx<Hospital?> selectedHospital = Rx<Hospital?>(null);

  // ---------------- DATE ----------------
  TextEditingController dateController = TextEditingController();
  RxString selectedDate = "".obs;

  // ---------------- TIME ----------------
  TextEditingController timeController = TextEditingController();
  RxString selectedTime = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadHospitals();
  }

  // ---------------- LOAD HOSPITALS ----------------
  void loadHospitals() {
    hospitals.value = [
      Hospital(id: "1", name: "City Hospital"),
      Hospital(id: "2", name: "Lotus Medical Center"),
      Hospital(id: "3", name: "Sunrise Hospital"),
    ];
    selectedHospital.value = hospitals.first;
  }

  void selectHospital(Hospital hospital) {
    selectedHospital.value = hospital;
  }

  // ---------------- DATE PICKER ----------------
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value = "${picked.day}-${picked.month}-${picked.year}";
      dateController.text = selectedDate.value;
    }
  }

  // ---------------- TIME PICKER ----------------
  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      selectedTime.value =
          "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
      timeController.text = selectedTime.value;
    }
  }

  // ---------------- BOOK APPOINTMENT ----------------
  void bookAppointment() {
    if (selectedHospital.value == null ||
        selectedDate.value.isEmpty ||
        selectedTime.value.isEmpty ||
        nameController.text.isEmpty
        ) {
      Get.snackbar("Error", "Please fill all details");
      return;
    }

    final pdata = {
      "name": nameController.text,
      "hospital": selectedHospital.value!.name,
      "date": selectedDate.value,
      "time": selectedTime.value,
    };

    ApiService.addData(pdata);
  }
}


class CancelAppointmentController extends GetxController {
  RxList<Appointment> appointments = <Appointment>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchApproved();
    super.onInit();
  }

  Future<void> fetchApproved() async {
    isLoading.value = true;
    appointments.value = await ApiService.getApprovedAppointments();
    isLoading.value = false;
  }

  Future<void> cancel(String id) async {
    final success = await ApiService.cancelAppointment(id);
    if (success) {
      appointments.removeWhere((a) => a.id == id);
      Get.snackbar("Cancelled", "Appointment cancelled");
    }
  }
}
