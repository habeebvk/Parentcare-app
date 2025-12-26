import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/screens/hospital/home_page.dart';


class HospitalNav extends StatefulWidget {
  const HospitalNav({super.key});

  @override
  State<HospitalNav> createState() => _HospitalNavState();
}

class _HospitalNavState extends State<HospitalNav> {
  int _pagesindex = 0;
  final List _pages = [
    HospitalHome(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pagesindex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _pagesindex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Color(0xffeb4034),
        buttonBackgroundColor: Color(0xffeb4034),
        items: [
          Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Icon(Icons.request_page, color: Colors.white),
        const SizedBox(height: 2),
        Text("Requests", style: GoogleFonts.poppins(color: Colors.white, fontSize: 10)),
        ],
        ),
        ],
        onTap: (index) {
          setState(() => _pagesindex = index);
        },
      ),
    );
  }
}