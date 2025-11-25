import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:parent_care/screens/alert_screen.dart';
import 'package:parent_care/screens/appointment_screen.dart';
import 'package:parent_care/screens/authentication/login.dart';
import 'package:parent_care/screens/authentication/register.dart';
import 'package:parent_care/screens/cab_screen.dart';
import 'package:parent_care/screens/grocery_screen.dart';
import 'package:parent_care/screens/home_screen.dart';
import 'package:parent_care/screens/hotel_screen.dart';
import 'package:parent_care/screens/into.dart';
import 'package:parent_care/screens/oldpeople_gallery.dart';
import 'package:parent_care/screens/spashscreen.dart';

class AppRoutes {
  static const intro = '/intro';
  static const login = '/login';
  static const register = '/register';
  static const appointment = '/appointment';
  static const cab = '/cab';
  static const grocery = '/grocery';
  static const home = '/home';
  static const oldpeople = '/oldpeople';
  static const notification = '/notification';
  static const food = '/food';
  static const splash = "/splash";


  static List<GetPage> pages = [
    GetPage(name: oldpeople, page: () => const OldPeopleGalleryScreen()),
    GetPage(name: home, page: () => const NavScreen()),
    GetPage(name: intro, page: () => const HomeScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: appointment,page: () => const AppointmentScreen()),
    GetPage(name: cab,page: () => CabBookingScreen()),
    GetPage(name: grocery,page: () => GroceryScreen()),
    GetPage(name: notification,page: () => NotificationScreen()),
    GetPage(name: food,page: () => FoodOrderingScreen()),
    GetPage(name: splash,page: () => SplashScreen())
  ];
}
