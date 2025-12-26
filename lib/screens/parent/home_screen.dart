import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/screens/parent/appointment_screen.dart';
import 'package:parent_care/screens/parent/cab_screen.dart';
import 'package:parent_care/screens/parent/grocery_screen.dart';
import 'package:parent_care/screens/parent/oldpeople_gallery.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _pageIndex = 0;

  final screens = [
     OldPeopleGalleryScreen(),
     AppointmentScreen(),
     CabMainScreen(),
     GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Color(0xffeb4034),
        buttonBackgroundColor: Color(0xffeb4034),
        items: [
          Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Icon(Icons.home, color: Colors.white),
        const SizedBox(height: 2),
        Text("Home", style: GoogleFonts.poppins(color: Colors.white, fontSize: 10)),
        ],
        ),
         Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            const Icon(Icons.local_hospital_outlined, color: Colors.white),
            const SizedBox(height: 2),
            Text("Hospital", style: GoogleFonts.poppins(color: Colors.white, fontSize: 10)),
          ],
         ),
         Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            const Icon(Icons.local_taxi, color: Colors.white),
            const SizedBox(height: 2),
            Text("Cab", style: GoogleFonts.poppins(color: Colors.white, fontSize: 10)),
          ],
         ),
         Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            const Icon(Icons.local_grocery_store, color: Colors.white),
            const SizedBox(height: 2),
            Text("Grocery", style: GoogleFonts.poppins(color: Colors.white, fontSize: 10)),
          ],
         ),
        ],
        onTap: (index) {
          setState(() => _pageIndex = index);
        },
      ),
      body: screens[_pageIndex],
    );
  }
}

