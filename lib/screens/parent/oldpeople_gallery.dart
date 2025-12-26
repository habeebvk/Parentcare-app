import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // ---------- RESPONSIVE GRID COUNT ----------
    int crossAxisCount = width < 500
        ? 2
        : width < 900
            ? 3
            : 4;

    // ---------- RESPONSIVE SIZING ----------
    double titleSize = width < 500 ? 20 : 26;
    double subtitleSize = width < 500 ? 14 : 16;
    double padding = width < 500 ? 12 : 20;
    double aspectRatio = width < 500 ? 0.85 : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          "Gallery",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          )
        ),
        centerTitle: true,
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
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final user = snapshot.data;

                // 👇 NOT Google login → keep existing UI
                if (user == null || user.photoURL == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_hospital,
                          size: 60, color: Colors.white),
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
                  );
                }

                // 👇 Google logged-in user
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.email ?? "",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
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
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                "Logout",
                style: GoogleFonts.poppins(color: Colors.red),
              ),
              onTap: () async {
                Get.back();

                // 🔥 Google + Firebase logout
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();

                // 🔥 Clear navigation stack
                Get.offAllNamed("/login");
              },
            ),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========== TITLE ==========
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              "Our Loved Seniors",
              style: GoogleFonts.poppins(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              "Caring, smiling, and inspiring lives every day...",
              style: GoogleFonts.poppins(
                fontSize: subtitleSize,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ========== RESPONSIVE GRID ==========
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(padding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: aspectRatio,
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
