import 'package:get/get.dart';
import 'package:parent_care/auth/auth_services.dart';

class RegisterController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  var isLoading = false.obs;

  final authService = FirebaseAuthServices();

  Future<void> register() async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    try {
      isLoading(true);

      final user = await authService.createUser(
        email.value.trim(),
        password.value.trim(),
      );

      if (user != null) {
        Get.snackbar("Success", "Account created successfully");
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar("Signup Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
