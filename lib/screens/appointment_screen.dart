import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/appointment_controller.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController controller = Get.put(AppointmentController());
    final theme = Theme.of(context);

    final width = MediaQuery.of(context).size.width;

    // ------------ RESPONSIVE VALUES ------------
    double titleSize = width < 500 ? 20 : 26;
    double sectionTitleSize = width < 500 ? 18 : 22;
    double inputFontSize = width < 500 ? 15 : 17;
    double padding = width < 500 ? 20 : 30;
    double spacing = width < 500 ? 12 : 20;
    double buttonHeight = width < 500 ? 55 : 65;

    final textColor = theme.textTheme.bodyLarge!.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Book Appointment",
          style: GoogleFonts.poppins(
            fontSize: titleSize,
            color: theme.appBarTheme.foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ----------- SELECT HOSPITAL -----------
              Text(
                "Select Hospital",
                style: GoogleFonts.poppins(
                  fontSize: sectionTitleSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(height: spacing),

              Obx(
                () => DropdownButtonFormField(
                  value: controller.selectedHospital.value,
                  decoration: InputDecoration(
                    labelText: "Select Hospital",
                    labelStyle: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: inputFontSize,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: width < 500 ? 14 : 18,
                    ),
                  ),
                  items: controller.hospitals.map((hospital) {
                    return DropdownMenuItem(
                      value: hospital,
                      child: Text(
                        hospital.name,
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: inputFontSize,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectHospital(value!);
                  },
                ),
              ),

              SizedBox(height: spacing * 2),

              // ----------- SELECT DATE -----------
              Text(
                "Select Date",
                style: GoogleFonts.poppins(
                  fontSize: sectionTitleSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(height: spacing),

              TextField(
                readOnly: true,
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontSize: inputFontSize,
                ),
                decoration: InputDecoration(
                  hintText: "Choose Date",
                  hintStyle: GoogleFonts.poppins(fontSize: inputFontSize),
                  suffixIcon: const Icon(Icons.calendar_month),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: width < 500 ? 14 : 18,
                  ),
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

              SizedBox(height: spacing * 2),

              // ----------- SELECT TIME -----------
              Text(
                "Select Time",
                style: GoogleFonts.poppins(
                  fontSize: sectionTitleSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(height: spacing),

              TextField(
                readOnly: true,
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontSize: inputFontSize,
                ),
                decoration: InputDecoration(
                  hintText: "Choose Time",
                  hintStyle: GoogleFonts.poppins(fontSize: inputFontSize),
                  suffixIcon: const Icon(Icons.schedule),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: width < 500 ? 14 : 18,
                  ),
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

              SizedBox(height: spacing * 3),

              // ----------- CONFIRM BUTTON -----------
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  minimumSize: Size(double.infinity, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  controller.bookAppointment();
                },
                child: Text(
                  "Confirm Appointment",
                  style: GoogleFonts.poppins(
                    fontSize: width < 500 ? 18 : 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
