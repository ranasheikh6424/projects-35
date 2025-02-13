import 'package:get/get.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';
import 'Auth_Controller.dart';

class ForgetPasswordVerifyOTPController extends GetxController {
  var inProgress = false.obs;
  var errorMessage = "".obs; // ✅ Make error message observable

  Future<bool> recoverVerifyOTP(String email, String otp) async {
    if (email.isEmpty || otp.isEmpty) {
      errorMessage.value = "Email or OTP can't be empty!";
      return false;
    }

    inProgress.value = true;
    final response =
        await NetworkCaller.getRequest(url: Urls.recoverVerifyotp(email, otp));

    inProgress.value = false;

    if (response.isSuccess && response.responseData != null) {
      if (response.responseData!['status'] == "success") {
        await AuthController.WriteOTPVerification(email, otp);
        errorMessage.value = ""; // ✅ Clear error message on success
        return true;
      } else {
        errorMessage.value = response.responseData!['data'] ?? "Invalid OTP";
        return false;
      }
    } else {
      errorMessage.value = response.errorMessage ?? "Something went wrong";
      return false;
    }
  }
}
