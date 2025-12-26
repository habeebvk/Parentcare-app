import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/hospital_controller.dart';

class HospitalHome extends StatelessWidget {
  const HospitalHome({super.key});

  @override
  Widget build(BuildContext context) {
    final HospitalController controller = Get.put(HospitalController());
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color actionBgColor = isDark ? Colors.white : Colors.black;
    final Color iconColor = isDark ? Colors.black : Colors.white;

    final width = MediaQuery.of(context).size.width;
    double buttonHeight = width < 500 ? 45 : 55;
    double spacing = width < 500 ? 16 : 20;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appointment Requests",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed('/login');
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(spacing),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.requests.isEmpty) {
            return Center(
              child: Text(
                "No appointment requests",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.requests.length,
            itemBuilder: (context, index) {
              final req = controller.requests[index];

              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: spacing),
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 👤 Name
                      Text(
                        "Name: ${req.name}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 6),

                      /// 📅 Date & Time
                      Text(
                        "Date: ${req.date} | Time: ${req.time}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// 🔘 Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  actionBgColor,
                              minimumSize: Size(100, buttonHeight),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(30)
                              )
                            ),
                            onPressed: () {
                              controller.approveRequest(req.id);
                            },
                            child: Text(
                              "Approve",
                              style: GoogleFonts.poppins(
                                color: iconColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  theme.colorScheme.error,
                              side: BorderSide(
                                color: theme.colorScheme.error,
                              ),
                              minimumSize: Size(100, buttonHeight),
                            ),
                            onPressed: () {
                              controller.rejectRequest(req.id);
                            },
                            child: Text(
                              "Reject",
                              style: GoogleFonts.poppins(
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
