import 'package:get/get.dart';
import '../Data/Modals/UserModal.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';
import 'Auth_Controller.dart';

class ResetPasswordController extends GetxController {
  var inProgress = false.obs;
  var errorMessage = ''.obs;

  Future<bool> resetPassword(
      String email, String password, String otp, String cPassword) async {
    if (password.length < 8) {
      errorMessage.value = "Password must be at least 8 characters";
      return false;
    }

    if (password != cPassword) {
      errorMessage.value = "Passwords do not match";
      return false;
    }

    inProgress.value = true;
    errorMessage.value = "";

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
      "OTP": otp,
      "cPassword": cPassword
    };

    final response = await NetworkCaller.postRequest(
        url: Urls.ResetPassword(), body: requestBody);

    inProgress.value = false;

    if (response.isSuccess && response.responseData != null) {
      if (response.responseData!['status'] == "success") {
        return true;
      } else {
        errorMessage.value =
            response.responseData!['data'] ?? "Invalid Request";
        return false;
      }
    } else {
      errorMessage.value = response.errorMessage ?? "Something went wrong";
      return false;
    }
  }
}
