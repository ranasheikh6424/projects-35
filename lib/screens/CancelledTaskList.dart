import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Data/Modals/TaskCOuntByStatusModal.dart';
import '../Data/Modals/TaskCOuntModal.dart';
import '../Data/Modals/TaskModal.dart';
import '../Data/Services/NetworkCaller.dart';
import '../Data/Utilis/Urls.dart';
import '../controllers/CancelledTaskController.dart';
import '../controllers/CompletedTaskController.dart';
import '../controllers/NewTskController.dart';
import '../controllers/ProgressTaskController.dart';
import '../widgets/CenterCircularProgress.dart';
import '../widgets/ScreenBackGround.dart';
import '../widgets/SnackBarMessage.dart';
import '../widgets/TaskItemWidget.dart';
import '../widgets/TaskStatusSummary_counter.dart';
import '../widgets/TmAppBar.dart';
import 'Add_New_Task_Screen.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelledTaskListScreen> {
  //bool _getTaskCountByStatusInProgress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  final CancelTaskController _CancelTaskController =
      Get.find<CancelTaskController>();

  @override
  void initState() {
    super.initState();
    //_getTaskCountByStatus();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //_buildTasksSummaryByStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GetBuilder<CancelTaskController>(builder: (controller) {
                  return Visibility(
                    visible: controller.getCancelledListInProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: _buildTaskListView(controller.taskList),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView(List<TaskModel> taskList) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskModel: taskList[index],
          taskId: taskList[index].sId!,
          taskTitle: taskList[index].title!,
          taskStatus: taskList[index].status!,
          taskDescription: taskList[index].description!,
          createdDate: taskList[index].createdDate!,
          onTaskUpdated: () async {
            await _getProgressTaskList();
          },
          onTaskDeleted: () async {
            await _getProgressTaskList();
          },
        );
      },
    );
  }

  Future<void> _getProgressTaskList() async {
    final bool isSuccess = await _CancelTaskController.getTaskList();
    if (!isSuccess) {
      showSnackBarMessage(context, _CancelTaskController.errorMessage!);
    }
  }
}
