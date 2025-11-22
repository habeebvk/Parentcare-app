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
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onNavTap,
        selectedItemColor: const Color(0xffeb4034),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital_outlined), label: "Appointment"),
          BottomNavigationBarItem(icon: Icon(Icons.local_taxi), label: "Cab"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store), label: "Grocery"),
        ],
      ),
    );
  }
}
