import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Data/Modals/TaskCOuntByStatusModal.dart';
import '../Data/Modals/TaskModal.dart';
import '../controllers/CompletedTaskController.dart';
import '../widgets/CenterCircularProgress.dart';
import '../widgets/ScreenBackGround.dart';
import '../widgets/SnackBarMessage.dart';
import '../widgets/TaskItemWidget.dart';
import '../widgets/TmAppBar.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  //bool _getTaskCountByStatusInProgress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  final CompletedTaskController _controller =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    //_getTaskCountByStatus();
    _getCompletedTaskList();
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
                child:
                    GetBuilder<CompletedTaskController>(builder: (controller) {
                  return Visibility(
                    visible: controller.getCompletedListInProgress == false,
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
            await _getCompletedTaskList();
          },
          onTaskDeleted: () async {
            await _getCompletedTaskList();
          },
        );
      },
    );
  }

  Future<void> _getCompletedTaskList() async {
    final bool isSuccess = await _controller.getTaskList();
    if (!isSuccess) {
      showSnackBarMessage(context, _controller.errorMessage!);
    }
  }
}
