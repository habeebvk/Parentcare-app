import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/alert_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // current theme
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: theme.appBarTheme.foregroundColor ?? theme.primaryColor,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor ??
            theme.scaffoldBackgroundColor,
        foregroundColor:
            theme.appBarTheme.foregroundColor ?? theme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: controller.clearAll,
          ),
        ],
      ),

      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Text(
              "No Notifications",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: theme.textTheme.bodyMedium!.color,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final item = controller.notifications[index];

            return GestureDetector(
              onTap: () => controller.markAsRead(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: item.isRead
                      ? (isDark ? Colors.grey.shade900 : Colors.grey.shade200)
                      : (isDark ? Colors.grey.shade800 : Colors.white),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                  ],
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon circle
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.red.withOpacity(0.15)
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.notifications_active,
                        color: const Color(0xffeb4034),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Text Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyLarge!.color,
                            ),
                          ),
                          const SizedBox(height: 6),

                          Text(
                            item.message,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            item.time,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall!.color,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Delete button
                    IconButton(
                      icon: Icon(Icons.close,
                          size: 18,
                          color: theme.iconTheme.color ?? Colors.grey),
                      onPressed: () => controller.deleteNotification(index),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
