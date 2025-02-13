import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';

class DeleteTaskController extends GetxController {
  var inProgress = false.obs;
  var errorMessage = ''.obs;
  var isDeleted = false.obs; // This will trigger UI update after deletion

  Future<bool> deleteTask(String taskId) async {
    inProgress.value = true;
    errorMessage.value = '';

    final response =
        await NetworkCaller.getRequest(url: Urls.DeleteTask(taskId));

    inProgress.value = false;

    if (response.isSuccess) {
      isDeleted.value = true; // Mark as deleted
      Get.snackbar("Success", "Task deleted successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      return true;
    } else {
      isDeleted.value = false;
      errorMessage.value = response.errorMessage ?? "Failed to delete task";
      Get.snackbar("Error", errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
  }
}
