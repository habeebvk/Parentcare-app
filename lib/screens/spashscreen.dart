import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.intro); // Go to your intro page
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // App logo (replace with your asset)
            Icon(
              Icons.health_and_safety,
              size: 150,
              color: theme.primaryColor,
            ),

            const SizedBox(height: 20),

            Text(
              "Parent Care",
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: theme.primaryColor,
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
