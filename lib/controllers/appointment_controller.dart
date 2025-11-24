import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
  // Observables
  RxList<Hospital> hospitals = <Hospital>[].obs;
  Rx<Hospital?> selectedHospital = Rx<Hospital?>(null);

  RxString selectedDate = "".obs;
  RxString selectedTime = "".obs;
  RxString tokenNumber = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadHospitals();
  }

  /// Load hospitals from Firebase, fallback to dummy data if Firestore empty
  void loadHospitals() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("hospitals").get();

      if (snapshot.docs.isNotEmpty) {
        hospitals.value = snapshot.docs.map((e) {
          return Hospital(
            id: e.id,
            name: e['name'],
            address: e['address'] ?? "",
          );
        }).toList();

        selectedHospital.value = hospitals.first;
      } else {
        // FALLBACK: Dummy hospitals
        hospitals.value = [
          Hospital(id: "1", name: "City Hospital", address: "Main Road"),
          Hospital(id: "2", name: "Lotus Medical Center", address: "Lake View"),
          Hospital(id: "3", name: "Sunrise Hospital", address: "Highway"),
        ];
        selectedHospital.value = hospitals.first;
      }
    } catch (e) {
      // If Firebase fails, load dummy hospitals
      hospitals.value = [
        Hospital(id: "1", name: "City Hospital", address: "Main Road"),
        Hospital(id: "2", name: "Lotus Medical Center", address: "Lake View"),
        Hospital(id: "3", name: "Sunrise Hospital", address: "Highway"),
      ];
      selectedHospital.value = hospitals.first;
    }
  }

  /// Select a hospital
  void selectHospital(Hospital hospital) {
    selectedHospital.value = hospital;
  }

  /// Save appointment to Firestore + show dialog
  Future<void> bookAppointment() async {
    if (selectedHospital.value == null ||
        selectedDate.value.isEmpty ||
        selectedTime.value.isEmpty) {
      Get.snackbar("Error", "Please fill all details");
      return;
    }

    // Generate token number
    tokenNumber.value =
        "TOK-${DateTime.now().millisecondsSinceEpoch % 1000}";

    try {
      await FirebaseFirestore.instance.collection("appointments").add({
        "hospitalId": selectedHospital.value!.id,
        "hospitalName": selectedHospital.value!.name,
        "date": selectedDate.value,
        "time": selectedTime.value,
        "token": tokenNumber.value,
        "createdAt": Timestamp.now(),
      });

      // Show confirmation dialog
      Get.defaultDialog(
        title: "Appointment Confirmed",
        middleText:
            "Hospital: ${selectedHospital.value!.name}\nDate: ${selectedDate.value}\nTime: ${selectedTime.value}\n\nYour Token: ${tokenNumber.value}",
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
