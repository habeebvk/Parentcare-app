import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/appointment_controller.dart';

class CancelAppointment extends StatefulWidget {
  const CancelAppointment({super.key});

  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  final CancelAppointmentController controller =
      Get.find<CancelAppointmentController>();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color actionBgColor = isDark ? Colors.white : Colors.black;
    final Color iconColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: controller.appointments.map((req) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).cardColor,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              req.hospital,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Date : ${req.date}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        /// ❌ Cancel Button
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: actionBgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            onPressed: () => controller.cancel(req.id),
                            icon: Icon(Icons.cancel, color: iconColor),
                          ),
                        ),

                        const SizedBox(width: 10),

                        /// ✏ Edit Button
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: actionBgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit, color: iconColor),
                          ),
                        ),

                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
