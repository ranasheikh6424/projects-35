import 'package:get/get.dart';
import 'package:task_manager/controllers/CancelledTaskController.dart';
import 'package:task_manager/controllers/ProgressTaskController.dart';
import 'package:task_manager/controllers/NewTskController.dart';
import 'package:task_manager/controllers/SignInController.dart';
import 'package:task_manager/controllers/UpdateTaskController.dart';

import 'controllers/CompletedTaskController.dart';
import 'controllers/CreateNewTaskController.dart';
import 'controllers/DeleteTaskController.dart';
import 'controllers/ForgerPasswordVerifyOTP.dart';
import 'controllers/ForgetPasswordVerifyEmail.dart';
import 'controllers/ResetPasswordController.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(Newtskcontroller()); // Fixed name and added parentheses
    Get.lazyPut(() => SignInController());
    Get.put(CompletedTaskController());
    Get.lazyPut(() => addNewtaskcontroller());
    Get.lazyPut(() => ForgetPasswordVerifyEmailController());
    Get.lazyPut(() => ForgetPasswordVerifyOTPController());

    Get.lazyPut(() => ResetPasswordController());
    Get.lazyPut(() => DeleteTaskController());
    Get.lazyPut(() => UpdateTaskController());

    // Fixed name
    Get.put(ProgressTaskController()); // Fixed syntax
    Get.put(CancelTaskController()); // Fixed name
  }
}
