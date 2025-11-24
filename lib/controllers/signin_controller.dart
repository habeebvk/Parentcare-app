import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      isLoading.value = true;

      await auth.signInWithEmailAndPassword(
        email: email.value.trim(),
        password: password.value.trim(),
      );

      Get.snackbar("Success", "Login successful");
      Get.offAllNamed('/home');

    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'user-not-found') {
        message = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else {
        message = e.message ?? "Login failed";
      }

      Get.snackbar("Error", message);

    } finally {
      isLoading.value = false;
    }
  }
}
