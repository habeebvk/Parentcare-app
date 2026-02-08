import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/grocery_controller.dart';
import 'package:parent_care/routes/routes.dart';
import 'package:parent_care/utility/responsive_helper.dart'; // <-- IMPORT RESPONSIVE

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Get.put(GroceryController());

      Get.offAllNamed(AppRoutes.intro);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ---- RESPONSIVE VALUES ----
    double logoSize = Responsive.isMobile(context)
        ? 140
        : Responsive.isTablet(context)
        ? 180
        : 220; // desktop

    double titleSize = Responsive.isMobile(context)
        ? 26
        : Responsive.isTablet(context)
        ? 32
        : 40;

    double spacing = Responsive.isMobile(context)
        ? 20
        : Responsive.isTablet(context)
        ? 30
        : 40;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo responsive
            Icon(
              Icons.health_and_safety,
              size: logoSize,
              color: theme.primaryColor,
            ),

            SizedBox(height: spacing),

            // Title responsive
            Text(
              "Parent Care",
              style: GoogleFonts.poppins(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: theme.primaryColor,
              ),
            ),

            SizedBox(height: spacing / 2),
          ],
        ),
      ),
    );
  }
}
