import 'package:get/get.dart';
import '../Data/Modals/TaskLIstByStatusModal.dart';
import '../Data/Modals/TaskModal.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';

class addNewtaskcontroller extends GetxController {
  bool _addNewTaskInProgress = false;

  bool get addTaskListInProgress => _addNewTaskInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  TaskListByStatusModel? _taskListByStatusModel;

  List<TaskModel> get taskList => _taskListByStatusModel?.taskList ?? [];

  Future<bool> createNewTask(String title, String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createTaskUrl,
      body: requestBody,
    );
    _addNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      update();
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
