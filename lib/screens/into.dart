import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/utility/responsive_helper.dart'; // <-- ADD THIS

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override  
  Widget build(BuildContext context) {

    // ---- RESPONSIVE VALUES ----
    double titleFont = Responsive.isMobile(context)
        ? 32
        : Responsive.isTablet(context)
            ? 40
            : 48;

    double descFont = Responsive.isMobile(context)
        ? 14
        : Responsive.isTablet(context)
            ? 18
            : 20;

    double sidePadding = Responsive.isMobile(context)
        ? 20
        : Responsive.isTablet(context)
            ? 60
            : 150;

    double topTitleSpacing = Responsive.isMobile(context)
        ? 160
        : Responsive.isTablet(context)
            ? 220
            : 260;

    double imageHeight = Responsive.isMobile(context)
        ? Responsive.screenHeight(context) * 1
        : Responsive.isTablet(context)
            ? Responsive.screenHeight(context) * 0.8
            : Responsive.screenHeight(context) * 0.9;

    double buttonTop = Responsive.isMobile(context)
        ? imageHeight - 60
        : Responsive.isTablet(context)
            ? imageHeight - 40
            : imageHeight - 20;

    double buttonHeight = Responsive.isMobile(context)
        ? 50
        : Responsive.isTablet(context)
            ? 55
            : 60;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            SizedBox(
              width: Responsive.screenWidth(context),
              height: imageHeight,
              child: const Image(
                image: AssetImage('assets/oldage.jpg'),
                fit: BoxFit.cover,
              ),
            ),

            // Title
            Positioned(
              left: sidePadding,
              top: topTitleSpacing,
              child: Text(
                "Aerofit",
                style: GoogleFonts.poppins(
                  fontSize: titleFont,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Description
            Positioned(
              left: sidePadding,
              right: sidePadding,
              top: topTitleSpacing + (Responsive.isMobile(context) ? 70 : 100),
              child: Text(
                "The golden hour, that fleeting period of time just after sunrise "
                "or before sunset, casts a magical and transformative glow upon "
                "the world. During these moments, the sun hangs low in the sky, "
                "its light diffused and warm, painting everything in shades of "
                "amber, gold, and soft orange...",
                style: GoogleFonts.poppins(
                  fontSize: descFont,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),

            // Get Started Button
            Positioned(
              left: sidePadding,
              right: sidePadding,
              top: buttonTop,
              child: SizedBox(
                height: buttonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins(
                      fontSize: Responsive.isMobile(context) ? 18 : 22,
                      color: Colors.black,
                    ),
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
