import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:parent_care/model/appointment_model.dart';
import 'package:parent_care/services/api_service.dart';


// --------- Appointment Request Model ----------
class AppointmentRequest {
  final String id;
  final String userName;
  final String date;
  final String time;
  String tokenNumber;
  String tokenDate;

  AppointmentRequest({
    required this.id,
    required this.userName,
    required this.date,
    required this.time,
    this.tokenNumber = "",
    this.tokenDate = "",
  });
}


class HospitalController extends GetxController {
  RxList<Appointment> requests = <Appointment>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      final data = await ApiService.getData();
      requests.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ APPROVE
  Future<void> approveRequest(String id) async {
    final success = await ApiService.approveAppointment(id);

    if (success) {
      requests.removeWhere((r) => r.id == id);
      Get.snackbar("Success", "Appointment approved");
    }
  }

  // ❌ REJECT
  Future<void> rejectRequest(String id) async {
    final success = await ApiService.rejectAppointment(id);

    if (success) {
      requests.removeWhere((r) => r.id == id);
      Get.snackbar("Rejected", "Appointment rejected");
    }
  }
}


