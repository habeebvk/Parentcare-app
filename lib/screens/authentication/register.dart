import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_care/controllers/register_controller.dart';
import 'package:parent_care/screens/widgets/auth_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 30),

                AuthField(
                  hint: "Full Name",
                  hintStyle: GoogleFonts.poppins(),
                  textStyle: GoogleFonts.poppins(),
                  onChanged: (val) => controller.name.value = val,
                ),
                const SizedBox(height: 16),

                AuthField(
                  hint: "Email Address",
                  hintStyle: GoogleFonts.poppins(),
                  textStyle: GoogleFonts.poppins(),
                  onChanged: (val) => controller.email.value = val,
                ),
                const SizedBox(height: 16),

                AuthField(
                  hint: "Password",
                  isPassword: true,
                  hintStyle: GoogleFonts.poppins(),
                  textStyle: GoogleFonts.poppins(),
                  onChanged: (val) => controller.password.value = val,
                ),
                const SizedBox(height: 30),

                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.register(),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Register",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Already have an account? Login",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
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

