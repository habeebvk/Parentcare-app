import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/screens/authentication/register.dart';
import 'package:parent_care/screens/authentication/static_credentials.dart';
import 'package:parent_care/screens/cab/cab_home.dart';
import 'package:parent_care/screens/parent/home_screen.dart';
import 'package:parent_care/screens/hospital/home_page.dart';
import 'package:parent_care/screens/parent/into.dart';
import 'package:parent_care/screens/widgets/auth_widget.dart';
import 'package:parent_care/services/api_service.dart';
import 'package:parent_care/services/google_auth.dart';
import 'package:parent_care/utility/responsive_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // -------------------------
  // REMOVE FIREBASE — Use Node API AuthService
  // -------------------------

  // final AuthService _auth = AuthService();  // <-- Your custom backend class
  final GoogleAuthService googleAuth = GoogleAuthService();

  final ApiService _authService = ApiService();
  String email = "";
  String password = "";
  bool isLoading = false;
  String selectedRole = "";

  final List<String> roles = [
    'Parent',
    "Hospital",
    "Cab",
    "Grocery",
    "Hotel"
  ];

final ApiService parentAuth = ApiService();

void login() async {
  if (email.isEmpty || password.isEmpty || selectedRole.isEmpty) {
    _showMessage("Please fill all fields");
    return;
  }

  setState(() => isLoading = true);

  /* ---------------- PARENT LOGIN (API) ---------------- */
  if (selectedRole == "Parent") {
    bool success = await parentAuth.login(
      email.trim(),
      password.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      Get.offAllNamed('/home');
    } else {
      _showMessage("Invalid Parent credentials");
    }
    return;
  }

  /* ---------------- STATIC LOGIN ---------------- */
  final staticUser = staticUsers[selectedRole];

  setState(() => isLoading = false);

  if (staticUser == null) {
    _showMessage("Role not supported");
    return;
  }

  if (email.trim() == staticUser['email'] &&
      password.trim() == staticUser['password']) {

    switch (selectedRole) {
      case "Hospital":
        Get.offAllNamed('/hospitalNav');
        break;

      case "Cab":
        Get.offAllNamed('/cabHome');
        break;

      case "Grocery":
        Get.offAllNamed('/groceryHome');
        break;

      case "Hotel":
        Get.offAllNamed('/foodOrder');
        break;
    }
  } else {
    _showMessage("Invalid credentials");
  }
}

  void googleLogin() async {
    setState(() => isLoading = true);

    final user = await googleAuth.signInWithGoogle();

    setState(() => isLoading = false);

    if (user != null) {
      Get.toNamed('/home');
    } else {
      _showMessage("Google Sign-In failed");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double titleSize = Responsive.isMobile(context)
        ? 28
        : Responsive.isTablet(context)
            ? 36
            : 44;

    double fieldSpacing = Responsive.isMobile(context)
        ? 16
        : Responsive.isTablet(context)
            ? 20
            : 24;

    double buttonHeight = Responsive.isMobile(context)
        ? 55
        : Responsive.isTablet(context)
            ? 60
            : 65;

    double horizontalPadding = Responsive.isMobile(context)
        ? 24
        : Responsive.isTablet(context)
            ? 80
            : 200;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ---------- TITLE ----------
                Text(
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffeb4034),
                  ),
                ),

                SizedBox(height: fieldSpacing * 2),

                // ---------- EMAIL ----------
                AuthField(
                  hint: "Email Address",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: Responsive.isMobile(context) ? 14 : 18,
                  ),
                  textStyle: GoogleFonts.poppins(
                    fontSize: Responsive.isMobile(context) ? 14 : 18,
                  ),
                  onChanged: (v) => email = v,
                ),

                SizedBox(height: fieldSpacing),

                // ---------- PASSWORD ----------
                AuthField(
                  hint: "Password",
                  isPassword: true,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: Responsive.isMobile(context) ? 14 : 18,
                  ),
                  textStyle: GoogleFonts.poppins(
                    fontSize: Responsive.isMobile(context) ? 14 : 18,
                  ),
                  onChanged: (v) => password = v,
                ),

                SizedBox(height: fieldSpacing),

                // ---------- ROLE SELECTOR ----------
                DropdownButtonFormField<String>(
                  value: selectedRole.isEmpty ? null : selectedRole,
                  decoration: const InputDecoration(
                    hintText: "Select Role",
                  ),
                  dropdownColor: Theme.of(context).cardColor,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  items: roles.map(
                    (role) => DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => selectedRole = value);
                  },
                ),
                SizedBox(height: fieldSpacing),

                // ---------- LOGIN BUTTON ----------
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffeb4034),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: isLoading ? null : login,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontSize: Responsive.isMobile(context) ? 18 : 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: fieldSpacing),

                // ---------- REGISTER BUTTON ----------
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: GoogleFonts.poppins(
                      fontSize: Responsive.isMobile(context) ? 14 : 18,
                      color: const Color(0xffeb4034),
                    ),
                  ),
                ),
                SizedBox(height: fieldSpacing),
// ---------- GOOGLE LOGIN BUTTON ----------
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: isLoading ? null : googleLogin,
                    icon: Image.asset(
                      "assets/gogle.png",
                      height: 22,
                    ),
                    label: Text(
                      "Continue with Google",
                      style: GoogleFonts.poppins(
                        fontSize: Responsive.isMobile(context) ? 16 : 18,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
