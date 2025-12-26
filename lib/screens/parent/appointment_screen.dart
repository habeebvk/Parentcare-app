import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/appointment_controller.dart';
import 'package:parent_care/screens/widgets/edit_cancel.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController controller = Get.put(AppointmentController());
    final theme = Theme.of(context);

    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2, // ----------- TWO TABS -----------
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,

        appBar: AppBar(
          title: Text(
            "Appointments",
            style: GoogleFonts.poppins(
              fontSize: width < 500 ? 20 : 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,

          // ----------- TABBAR -----------
          bottom: const TabBar(
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(text: "Book"),
              Tab(text: "My Appointments"),
            ],
          ),
        ),

        // ----------- TABBAR VIEWS -----------
        body: TabBarView(
          children: [
            _buildBookingForm(context, controller, width),
            CancelAppointment()
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------
  // TAB 1 : BOOKING FORM (Your Existing UI)
  // ---------------------------------------------
  Widget _buildBookingForm(BuildContext context,
      AppointmentController controller, double width) {
    double sectionTitleSize = width < 500 ? 18 : 22;
    double inputFontSize = width < 500 ? 15 : 17;
    double padding = width < 500 ? 20 : 30;
    double spacing = width < 500 ? 12 : 20;
    double buttonHeight = width < 500 ? 55 : 65;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- Select Hospital ----------
            Text(
              "Enter Name",
              style: GoogleFonts.poppins(
                fontSize: sectionTitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing),

            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hint: Text("Enter Name",style: GoogleFonts.poppins()),
                suffixIcon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: spacing * 2),
            Text(
              "Select Hospital",
              style: GoogleFonts.poppins(
                fontSize: sectionTitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing),

            Obx(
              () => DropdownButtonFormField(
                value: controller.selectedHospital.value,
                decoration: InputDecoration(
                  labelText: "Select Hospital",
                  labelStyle: GoogleFonts.poppins(),
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
                      style: GoogleFonts.poppins(fontSize: inputFontSize),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectHospital(value!);
                },
              ),
            ),

            SizedBox(height: spacing * 2),

            // -------- Select Date ----------
            Text(
              "Select Date",
              style: GoogleFonts.poppins(
                fontSize: sectionTitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing),

            TextField(
              controller: controller.dateController,
              onTap: () => controller.pickDate(context),
              decoration: InputDecoration(
                hint: Text("Enter Date",style: GoogleFonts.poppins(),),
                suffixIcon: Icon(Icons.calendar_month)
              ),
            ),
            SizedBox(height: spacing * 2),

            // -------- Select Time ----------
            Text(
              "Select Time",
              style: GoogleFonts.poppins(
                fontSize: sectionTitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing),

            TextField(
              controller: controller.timeController,
              readOnly: true,
              onTap: () => controller.pickTime(context),
              decoration: InputDecoration(
                hint: Text("Enter Time",style: GoogleFonts.poppins()),
                suffixIcon: Icon(Icons.timer)
              ),
            ),
            SizedBox(height: spacing * 3),

            // -------- Confirm Button ----------
            SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
