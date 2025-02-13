import 'package:get/get.dart';
import '../Data/Modals/UserModal.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';
import 'Auth_Controller.dart';

class ForgetPasswordVerifyEmailController extends GetxController {
  var inProgress = false.obs;
  String? errorMessage;

  Future<bool> recoverVerifyEmail(String Email) async {
    if (Email.isEmpty) {
      errorMessage = "Email can't be empty!";
      return false;
    }

    inProgress.value = true;
    final response =
        await NetworkCaller.getRequest(url: Urls.recoverVerifyemail(Email));

    if (response.isSuccess) {
      await AuthController.WriteEmailVerification(Email);
      inProgress.value = false;
      return true;
    } else {
      errorMessage = response.statusCode == 401
          ? 'Incorrect email'
          : response.errorMessage;
      inProgress.value = false;
      return false;
    }
  }
}
