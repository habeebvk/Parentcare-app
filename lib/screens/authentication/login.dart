import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/auth/auth_services.dart';
import 'package:parent_care/screens/authentication/register.dart';
import 'package:parent_care/screens/home_screen.dart';
import 'package:parent_care/screens/into.dart';
import 'package:parent_care/screens/widgets/auth_widget.dart';

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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffeb4034),
                  ),
                ),
                const SizedBox(height: 30),

                AuthField(
                  hint: "Email Address",
                  hintStyle: GoogleFonts.poppins(),
                  textStyle: GoogleFonts.poppins(),
                  onChanged: (v) => email = v,
                ),
                const SizedBox(height: 16),

                AuthField(
                  hint: "Password",
                  isPassword: true,
                  hintStyle: GoogleFonts.poppins(),
                  textStyle: GoogleFonts.poppins(),
                  onChanged: (v) => password = v,
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
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
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),

                const SizedBox(height: 20),

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
                      color: const Color(0xffeb4034),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
