import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_care/controllers/theme_controller.dart';
import 'package:parent_care/routes/routes.dart';
import 'package:parent_care/services/flutter_notification_service.dart';
import 'package:parent_care/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseBackgroundHandler,
  );
  // Initialize notifications
  await NotificationService.initialize();
  runApp(ParentCareApp());
}


class ParentCareApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Elegant Auth UI",
        themeMode: themeController.theme,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.pages,
      );
    });
  }
}

