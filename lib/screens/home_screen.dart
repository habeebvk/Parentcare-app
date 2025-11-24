import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/screens/appointment_screen.dart';
import 'package:parent_care/screens/cab_screen.dart';
import 'package:parent_care/screens/grocery_screen.dart';
import 'package:parent_care/screens/oldpeople_gallery.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    OldPeopleGalleryScreen(),
    AppointmentScreen(),
    CabBookingScreen(),
    GroceryScreen(),
  ];

  void onNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true, // needed for floating effect
      body: _pages[_selectedIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffeb4034),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,

              currentIndex: _selectedIndex,
              onTap: onNavTap,

              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,

              selectedLabelStyle:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
              unselectedLabelStyle:
                  GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12),

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_hospital_outlined),
                  label: "Appointment",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_taxi),
                  label: "Cab",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_grocery_store),
                  label: "Grocery",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
