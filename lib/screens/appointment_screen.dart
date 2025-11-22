import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/screens/widgets/hospital_card.dart';
import '../controllers/appointment_controller.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController controller = Get.put(AppointmentController());
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge!.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Book Appointment",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: theme.appBarTheme.foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Select Hospital",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
              const SizedBox(height: 12),

              Obx(() => DropdownButtonFormField(
                value: controller.selectedHospital.value,
                decoration: InputDecoration(
                  labelText: "Select Hospital",
                  labelStyle: GoogleFonts.poppins(color: textColor),
                ),
                items: controller.hospitals.map((hospital) {
                  return DropdownMenuItem(
                    value: hospital,
                    child: Text(
                      hospital.name,
                      style: GoogleFonts.poppins(color: textColor),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectHospital(value!);
                },
              )),

              const SizedBox(height: 25),

              Text("Select Date",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
              const SizedBox(height: 12),

              TextField(
                readOnly: true,
                style: GoogleFonts.poppins(color: textColor),
                decoration: InputDecoration(
                  hintText: "Choose Date",
                  hintStyle: GoogleFonts.poppins(),
                  suffixIcon: const Icon(Icons.calendar_month),
                ),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now(),
                  );
                  if (picked != null) {
                    controller.selectedDate.value =
                        "${picked.day}-${picked.month}-${picked.year}";
                  }
                },
              ),

              const SizedBox(height: 25),

              Text("Select Time",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
              const SizedBox(height: 12),

              TextField(
                readOnly: true,
                style: GoogleFonts.poppins(color: textColor),
                decoration: InputDecoration(
                  hintText: "Choose Time",
                  hintStyle: GoogleFonts.poppins(),
                  suffixIcon: const Icon(Icons.schedule),
                ),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    controller.selectedTime.value =
                        "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
                  }
                },
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  controller.bookAppointment();
                },
                child: Text(
                  "Confirm Appointment",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

