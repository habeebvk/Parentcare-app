import 'package:get/get.dart';
import 'package:parent_care/model/hospital_model.dart';

class AppointmentController extends GetxController {
  var hospitals = <Hospital>[].obs;
  var selectedHospital = Rx<Hospital?>(null);
  var selectedDate = ''.obs;
  var selectedTime = ''.obs;

  var tokenNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Dummy hospital list
    hospitals.value = [
      Hospital(id: 1, name: "City Hospital", address: "Main Road, Town"),
      Hospital(id: 2, name: "Lotus Medical Center", address: "Lake View, City"),
      Hospital(id: 3, name: "Sunrise Hospital", address: "Highway Junction"),
    ];
  }

  void selectHospital(Hospital hospital) {
    selectedHospital.value = hospital;
  }

  void bookAppointment() {
    if (selectedHospital.value == null ||
        selectedDate.isEmpty ||
        selectedTime.isEmpty) {
      Get.snackbar("Error", "Please fill all details");
      return;
    }

    // Generate token (dummy logic)
    tokenNumber.value = "TOK-${DateTime.now().millisecondsSinceEpoch % 1000}";

    Get.defaultDialog(
      title: "Appointment Confirmed",
      middleText:
          "Hospital: ${selectedHospital.value!.name}\nDate: ${selectedDate}\nTime: ${selectedTime}\n\nYour Token: ${tokenNumber.value}",
    );
  }
}
