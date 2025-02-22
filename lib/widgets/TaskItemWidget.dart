import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/Modals/TaskModal.dart';
import '../controllers/UpdateTaskController.dart';
import '../controllers/DeleteTaskController.dart';

class TaskItemWidget extends StatelessWidget {
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final String taskStatus;
  final String createdDate;
  final VoidCallback onTaskUpdated;
  final VoidCallback onTaskDeleted;

  final UpdateTaskController _updateController =
      Get.find<UpdateTaskController>();
  final DeleteTaskController _deleteController =
      Get.find<DeleteTaskController>();

  TaskItemWidget({
    super.key,
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskStatus,
    required this.createdDate,
    required this.onTaskUpdated,
    required this.onTaskDeleted,
    required TaskModel taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title:
                Text(taskTitle, style: Theme.of(context).textTheme.titleLarge),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(taskDescription),
                Text(createdDate),
                Container(
                  decoration: BoxDecoration(
                    color: getStatusColor(taskStatus),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(taskStatus,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _showUpdateStatusBottomSheet(context),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _confirmDeleteTask(context),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(), // Close dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Get.back(); // Close dialog before deletion
                bool success = await _deleteController.deleteTask(taskId);
                if (success) {
                  onTaskDeleted(); // Auto-refresh task list
                  Get.snackbar(
                    //borderColor: Colors.amberAccent,
                    "Success",
                    "Task deleted successfully!",
                    // backgroundGradient: Gradient.lerp(a, b, t),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    "Failed to delete task",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateStatusBottomSheet(BuildContext context) {
    String selectedStatus = taskStatus;
    final UpdateTaskController _taskController =
        Get.find<UpdateTaskController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ✅ Prevents overflow
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          // ✅ Allows scrolling if content overflows
          expand: false,
          initialChildSize: 0.5, // Adjust this value
          maxChildSize: 0.9,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController, // ✅ Allows scrolling
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Task Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    _statusRadioTile("New", selectedStatus, (value) {
                      selectedStatus = value!;
                    }),
                    _statusRadioTile("Progress", selectedStatus, (value) {
                      selectedStatus = value!;
                    }),
                    _statusRadioTile("Completed", selectedStatus, (value) {
                      selectedStatus = value!;
                    }),
                    _statusRadioTile("Cancelled", selectedStatus, (value) {
                      selectedStatus = value!;
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
                      return _taskController.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                await _taskController.updateTaskStatus(
                                    taskId, selectedStatus);
                                onTaskUpdated(); // Refresh task list
                                Get.back(); // Close Bottom Sheet
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Update Status"),
                            );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// **Reusable Widget for Status Options**
  Widget _statusRadioTile(
      String title, String selectedValue, Function(String?) onChanged) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: selectedValue,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'progress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey; // Default color for unknown status
    }
  }
}
