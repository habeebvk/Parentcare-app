 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/theme_controller.dart';

class OldPeopleGalleryScreen extends StatelessWidget {
  const OldPeopleGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/old1.jpg",
      "assets/old2.jpg",
      "assets/old3.jpg",
      "assets/old4.jpg",
      "assets/old5.jpg",
    ];

    return Scaffold(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,

  appBar: AppBar(
    title: Text(
      "Old People Gallery",
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    ),
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Theme.of(context).iconTheme.color,
    ),
  ),

 drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xffeb4034),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_hospital, size: 60, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    "Parent Care Menu",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.local_hospital_outlined),
              title: Text("Hospital", style: GoogleFonts.poppins()),
              onTap: () {
                Get.back();
                Get.toNamed("/appointment");
              },
            ),

            ListTile(
              leading: const Icon(Icons.local_taxi),
              title: Text("Cab Booking", style: GoogleFonts.poppins()),
              onTap: () {
                Get.back();
                Get.toNamed("/cab");
              },
            ),

            ListTile(
              leading: const Icon(Icons.store),
              title: Text("Grocery", style: GoogleFonts.poppins()),
              onTap: () {
                Get.back();
                Get.toNamed("/grocery");
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: Text("Notification", style: GoogleFonts.poppins()),
              onTap: () {
                Get.back();
                Get.toNamed("/notification");
              },
            ),

            ListTile(
              leading: const Icon(Icons.hotel),
              title: Text("Food Order", style: GoogleFonts.poppins()),
              onTap: () {
                Get.back();
                Get.toNamed("/food");
              },
            ),

            const Divider(),

            // 🔥 TOGGLE SWITCH FOR DARK/LIGHT MODE
            Obx(() {
                final themeController = Get.find<ThemeController>();
                return SwitchListTile(
                  title: Text("Dark Mode", style: GoogleFonts.poppins()),
                  secondary: Icon(
                    themeController.isDarkMode.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  value: themeController.isDarkMode.value,
                  onChanged: (value) {
                    themeController.toggleTheme(value);
                  },
                );
              }),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ------- Section Title ------
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Our Loved Seniors",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Caring, smiling, and inspiring lives every day...",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        ),

          const SizedBox(height: 15),

          // ------- Image Grid -------
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
