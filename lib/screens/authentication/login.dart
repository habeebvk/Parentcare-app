import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/auth/auth_services.dart';
import 'package:parent_care/screens/authentication/register.dart';
import 'package:parent_care/screens/home_screen.dart';
import 'package:parent_care/screens/widgets/auth_widget.dart';
import 'package:parent_care/utility/responsive_helper.dart'; // <-- ADD THIS

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  String email = "";
  String password = "";
  bool isLoading = false;

  void login() async {
    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please enter email and password");
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = await _auth.loginUser(email.trim(), password.trim());

      if (user != null) {
        _showMessage("Login Successful");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NavScreen()),
        );
      }
    } catch (error) {
      _showMessage(error.toString());
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {

    // -------- RESPONSIVE VALUES --------
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

                SizedBox(height: fieldSpacing * 2),

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
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
