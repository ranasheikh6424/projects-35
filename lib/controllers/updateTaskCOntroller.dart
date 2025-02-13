import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';

class UpdateTaskController extends GetxController {
  var isLoading = false.obs; // Track the loading state
  var errorMessage = ''.obs;

  Future<bool> updateTaskStatus(String taskId, String newStatus) async {
    isLoading.value = true; // Show loading spinner
    errorMessage.value = '';

    // Assume this is your API call to update task status
    final response =
        await NetworkCaller.getRequest(url: Urls.UpdateTask(taskId, newStatus));

    isLoading.value = false; // Hide loading spinner once done

    if (response.isSuccess) {
      Get.snackbar("Success", "Task status updated successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      return true;
    } else {
      errorMessage.value =
          response.errorMessage ?? "Failed to update task status";
      Get.snackbar("Error", errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
  }
}
