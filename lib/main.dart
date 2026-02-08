import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_care/controllers/theme_controller.dart';
import 'package:parent_care/routes/routes.dart';
import 'package:parent_care/services/flutter_notification_service.dart';
import 'package:parent_care/themes/app_theme.dart';
import 'package:parent_care/bindings/all_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseBackgroundHandler,
  );
  // Initialize notifications
  await NotificationService.initialize();

  // Initialize Global Bindings (Themes, etc)
  InitialConfigBinding().dependencies();

  runApp(ParentCareApp());
}

class ParentCareApp extends StatelessWidget {
  // Removed direct Get.put
  // final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Find controller since it's now bound
      // Find controller since it's now bound
      Get.find<ThemeController>();
      // Wait, InitialBinding runs with GetMaterialApp init usually, but we need Theme for GetMaterialApp properties?
      // Actually InitialBinding is executed when GetMaterialApp is built.
      // Accessing themeController BEFORE GetMaterialApp might be tricky if it's not put yet.
      // If we use initialBinding, it initializes interacting with GetMaterialApp.
      // But we need themeController.theme for themeMode property of GetMaterialApp.
      // Catch-22?
      // If we used Get.put(..., permanent: true) in main() before runApp, that works.
      // Or we use GetMaterialApp(initialBinding: ...) and Get.find inside the builder or property?
      // Properties like themeMode are read immediately.
      // Standard pattern:
      // option 1: Bindings().dependencies() called on init.
      // option 2: Put in main() before runApp.
      // User asked to put ALL Get.put in bindings file.
      // So InitialConfigBinding should be used.
      // But we need the theme for the app widget itself.
      // Let's rely on Get.find() working if we pass initialBinding.
      // modifying the code to use Get.find inside Obx, but we need to ensure it's initialized.
      // GetMaterialApp takes `initialBinding`.

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Elegant Auth UI",
        themeMode: Get.find<ThemeController>().theme, // Access here
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.pages,
      );
    });
  }
}
