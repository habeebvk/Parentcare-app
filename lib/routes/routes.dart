import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:parent_care/screens/parent/alert_screen.dart';
import 'package:parent_care/screens/parent/appointment_screen.dart';
import 'package:parent_care/screens/authentication/login.dart';
import 'package:parent_care/screens/authentication/register.dart';
import 'package:parent_care/screens/cab/cab_home.dart';
import 'package:parent_care/screens/parent/cab_screen.dart';
import 'package:parent_care/screens/grocery/grocery_home.dart';
import 'package:parent_care/screens/parent/grocery_screen.dart';
import 'package:parent_care/screens/parent/home_screen.dart';
import 'package:parent_care/screens/hospital/home_page.dart';
import 'package:parent_care/screens/hospital/hospitalNav.dart';
import 'package:parent_care/screens/hotel/hotel_screen.dart';
import 'package:parent_care/screens/parent/hotel_screen.dart';
import 'package:parent_care/screens/parent/into.dart';
import 'package:parent_care/screens/parent/oldpeople_gallery.dart';
import 'package:parent_care/screens/parent/spashscreen.dart';
import 'package:parent_care/bindings/all_bindings.dart';

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
  static const hospital = "/hospital";
  static const hospitalNav = "/hospitalNav";
  static const cabHome = "/cabHome";
  static const groceryHome = '/groceryHome';
  static const foodOrder = '/foodOrder';

  static List<GetPage> pages = [
    GetPage(name: oldpeople, page: () => const OldPeopleGalleryScreen()),
    GetPage(
      name: home,
      page: () => NavScreen(),
      binding: NavBinding(),
    ),
    GetPage(
      name: intro,
      page: () => const HomeScreen(),
    ), // HomeScreen typically is entry, check if binding needed
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(
      name: appointment,
      page: () => const AppointmentScreen(),
      binding: AppointmentBinding(),
    ),
    GetPage(name: cab, page: () => CabBookingScreen(), binding: CabBinding()),
    GetPage(
      name: grocery,
      page: () => GroceryScreen(),
      binding: GroceryBinding(),
    ),
    GetPage(
      name: notification,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: food,
      page: () => FoodOrderingScreen(),
      binding: FoodBinding(),
    ),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(
      name: hospital,
      page: () => HospitalHome(),
      binding: HospitalBinding(),
    ),
    GetPage(
      name: hospitalNav,
      page: () => HospitalNav(),
      binding: HospitalBinding(),
    ), // Reuse hospital binding?
    GetPage(
      name: groceryHome,
      page: () => OrderSummaryScreen(),
      binding: GroceryBinding(),
    ), // Reuse grocery binding
    GetPage(name: cabHome, page: () => CabHome(), binding: CabBinding()),
    GetPage(
      name: foodOrder,
      page: () => FoodOrdersScreen(),
      binding: FoodBinding(),
    ),
  ];
}
