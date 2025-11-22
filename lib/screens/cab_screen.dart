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
    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyMedium?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Auto change
      appBar: AppBar(
        title: Text(
          "Book a Cab",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: textColor,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Pickup
            TextField(
              controller: controller.pickupController,
              style: GoogleFonts.poppins(color: textColor),
              decoration: InputDecoration(
                labelText: "Pickup Location",
                labelStyle: GoogleFonts.poppins(color: textColor),
                filled: true,
                fillColor: cardColor, // auto change
                prefixIcon: Icon(Icons.location_on_outlined,
                    color: theme.iconTheme.color),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Drop
            TextField(
              controller: controller.dropController,
              style: GoogleFonts.poppins(color: textColor),
              decoration: InputDecoration(
                labelText: "Drop Location",
                labelStyle: GoogleFonts.poppins(color: textColor),
                filled: true,
                fillColor: cardColor,
                prefixIcon: Icon(Icons.flag_outlined,
                    color: theme.iconTheme.color),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Time Picker
            Obx(
              () => GestureDetector(
                onTap: () => controller.chooseTime(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: theme.dividerColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time,
                          color: theme.iconTheme.color),
                      const SizedBox(width: 12),
                      Text(
                        controller.selectedTime.value == null
                            ? "Select Time"
                            : "${controller.selectedTime.value!.hour.toString().padLeft(2, '0')}"
                              ":${controller.selectedTime.value!.minute.toString().padLeft(2, '0')}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Book Cab Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.bookCab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor, // auto mode color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Book Cab",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
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
