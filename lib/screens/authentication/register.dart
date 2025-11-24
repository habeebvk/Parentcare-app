import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/auth/auth_services.dart';
import 'package:parent_care/screens/authentication/login.dart';
import 'package:parent_care/screens/into.dart';
import 'package:parent_care/screens/widgets/auth_widget.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  String name = "";
  String email = "";
  String password = "";
  bool isLoading = false;

  void register() async {
    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = await _auth.createUser(email.trim(), password.trim());

      if (user != null) {
        _showMessage("Account created!");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (error) {
      _showMessage(error.toString());
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffeb4034),
                  ),
                ),
                const SizedBox(height: 30),

                AuthField(
                  hint: "Full Name",
                  hintStyle: GoogleFonts.poppins(),
                  textStyle: GoogleFonts.poppins(),
                  onChanged: (v) => name = v,
                ),
                const SizedBox(height: 16),

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
                  onPressed: isLoading ? null : register,
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
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: GoogleFonts.poppins(
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
