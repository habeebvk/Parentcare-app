import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/cab_controller.dart';

class CabBookingScreen extends StatelessWidget {
  CabBookingScreen({super.key});

  final controller = Get.put(CabBookingController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ------------ RESPONSIVE VALUES ------------
    final width = MediaQuery.of(context).size.width;

    double titleSize = width < 500 ? 20 : 26;
    double inputFontSize = width < 500 ? 15 : 18;
    double padding = width < 500 ? 20 : 32;
    double spacing = width < 500 ? 20 : 28;
    double buttonHeight = width < 500 ? 55 : 65;

    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyMedium?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Book a Cab",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: titleSize,
            color: textColor,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [

            // -------- Pickup --------
            TextField(
              controller: controller.pickupController,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: inputFontSize,
              ),
              decoration: InputDecoration(
                labelText: "Pickup Location",
                labelStyle: GoogleFonts.poppins(
                  color: textColor,
                  fontSize: inputFontSize,
                ),
                filled: true,
                fillColor: cardColor,
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: theme.iconTheme.color,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: width < 500 ? 14 : 18,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            SizedBox(height: spacing),

            // -------- Drop --------
            TextField(
              controller: controller.dropController,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: inputFontSize,
              ),
              decoration: InputDecoration(
                labelText: "Drop Location",
                labelStyle: GoogleFonts.poppins(
                  color: textColor,
                  fontSize: inputFontSize,
                ),
                filled: true,
                fillColor: cardColor,
                prefixIcon: Icon(
                  Icons.flag_outlined,
                  color: theme.iconTheme.color,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: width < 500 ? 14 : 18,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            SizedBox(height: spacing),

            // -------- Time Picker --------
            Obx(
              () => GestureDetector(
                onTap: () => controller.chooseTime(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: width < 500 ? 14 : 18,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: theme.dividerColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: theme.iconTheme.color),
                      const SizedBox(width: 12),
                      Text(
                        controller.selectedTime.value == null
                            ? "Select Time"
                            : "${controller.selectedTime.value!.hour.toString().padLeft(2, '0')}:${controller.selectedTime.value!.minute.toString().padLeft(2, '0')}",
                        style: GoogleFonts.poppins(
                          fontSize: inputFontSize,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            // -------- Book Button --------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.bookCab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  minimumSize: Size(double.infinity, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Book Cab",
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
