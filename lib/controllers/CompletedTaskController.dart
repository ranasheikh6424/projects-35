import 'package:get/get.dart';
import '../Data/Modals/TaskLIstByStatusModal.dart';
import '../Data/Modals/TaskModal.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';

class CompletedTaskController extends GetxController {
  bool _CompletedTaskInProgress = false;

  bool get getCompletedListInProgress => _CompletedTaskInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  TaskListByStatusModel? _taskListByStatusModel;

  List<TaskModel> get taskList => _taskListByStatusModel?.taskList ?? [];

  Future<bool> getTaskList() async {
    bool isSuccess = false;
    _CompletedTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.taskListByStatusUrl('Completed'),
    );
    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _CompletedTaskInProgress = false;
    update();
    return isSuccess;
  }
}
