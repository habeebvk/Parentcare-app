import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/alert_controller.dart';
import 'package:parent_care/utility/responsive_helper.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // --------- RESPONSIVE VALUES -----------
    double padding = Responsive.isMobile(context) ? 16 : 28;
    double cardPadding = Responsive.isMobile(context) ? 16 : 24;
    double titleSize = Responsive.isMobile(context) ? 16 : 22;
    double messageSize = Responsive.isMobile(context) ? 14 : 18;
    double timeSize = Responsive.isMobile(context) ? 12 : 16;
    double iconBoxSize = Responsive.isMobile(context) ? 40 : 55;
    double notificationIconSize = Responsive.isMobile(context) ? 22 : 30;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(
            fontSize: Responsive.isMobile(context) ? 20 : 28,
            fontWeight: FontWeight.w600,
            color: theme.appBarTheme.foregroundColor ?? theme.primaryColor,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? theme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep,
                size: Responsive.isMobile(context) ? 22 : 30),
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
                fontSize: Responsive.isMobile(context) ? 16 : 24,
                color: theme.textTheme.bodyMedium!.color,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(padding),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final item = controller.notifications[index];

            return GestureDetector(
              onTap: () => controller.markAsRead(index),
              child: Container(
                margin: EdgeInsets.only(bottom: padding),
                padding: EdgeInsets.all(cardPadding),
                decoration: BoxDecoration(
                  color: item.isRead
                      ? (isDark ? Colors.grey.shade900 : Colors.grey.shade200)
                      : (isDark ? Colors.grey.shade800 : Colors.white),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon circle
                    Container(
                      height: iconBoxSize,
                      width: iconBoxSize,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.red.withOpacity(0.15)
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.notifications_active,
                        size: notificationIconSize,
                        color: const Color(0xffeb4034),
                      ),
                    ),

                    SizedBox(width: Responsive.isMobile(context) ? 14 : 22),

                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.poppins(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyLarge!.color,
                            ),
                          ),
                          SizedBox(height: Responsive.isMobile(context) ? 6 : 10),

                          Text(
                            item.message,
                            style: GoogleFonts.poppins(
                              fontSize: messageSize,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          SizedBox(height: Responsive.isMobile(context) ? 8 : 12),

                          Text(
                            item.time,
                            style: GoogleFonts.poppins(
                              fontSize: timeSize,
                              color: theme.textTheme.bodySmall!.color,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Delete button
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: Responsive.isMobile(context) ? 18 : 26,
                        color: theme.iconTheme.color ?? Colors.grey,
                      ),
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
