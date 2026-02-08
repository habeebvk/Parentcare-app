import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:parent_care/controllers/nav_controller.dart';

import 'package:parent_care/screens/parent/appointment_screen.dart';
import 'package:parent_care/screens/parent/cab_screen.dart';
import 'package:parent_care/screens/parent/grocery_screen.dart';
import 'package:parent_care/screens/parent/oldpeople_gallery.dart';

class NavScreen extends GetView<NavController> {
  NavScreen({super.key});

  final screens = [
    const OldPeopleGalleryScreen(),
    const AppointmentScreen(),
    const CabMainScreen(),
    GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: screens[controller.currentIndex.value],
        bottomNavigationBar: CurvedNavigationBar(
          index: controller.currentIndex.value,
          height: 60,
          backgroundColor: Colors.transparent,
          color: const Color(0xffeb4034),
          buttonBackgroundColor: const Color(0xffeb4034),

          items: [
            _navItem(Icons.home, "Home"),
            _navItem(Icons.local_hospital_outlined, "Hospital"),
            _navItem(Icons.local_taxi, "Cab"),
            _navItem(Icons.local_grocery_store, "Grocery"),
          ],

          onTap: controller.changePage,
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
