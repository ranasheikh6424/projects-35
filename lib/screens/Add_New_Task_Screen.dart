import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/CreateNewTaskController.dart';
import '../widgets/CenterCircularProgress.dart';
import '../widgets/ScreenBackGround.dart';
import '../widgets/TmAppBar.dart';

class AddNewTaskScreen extends StatelessWidget {
  AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  final addNewtaskcontroller _newcontroller = Get.put(addNewtaskcontroller());

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text('Add New Task',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                _buildTextField(_titleTEController, 'Title'),
                const SizedBox(height: 16),
                _buildTextField(_descriptionTEController, 'Description',
                    maxLines: 6),
                const SizedBox(height: 16),
                GetBuilder<addNewtaskcontroller>(builder: (controller) {
                  return controller.addTaskListInProgress
                      ? const CenteredCircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            _validateAndSubmit();
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(hintText: hint),
      validator: (value) =>
          value!.trim().isEmpty ? 'Enter your $hint here' : null,
    );
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _newcontroller.createNewTask(
        _titleTEController.text.trim(),
        _descriptionTEController.text.trim(),
      );
      if (success) {
        Get.snackbar('Success', 'Task added successfully',
            snackPosition: SnackPosition.BOTTOM);
        _newcontroller.update();

        _clearTextFields();
      } else {
        Get.snackbar(
            'Error', _newcontroller.errorMessage ?? 'Something went wrong',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
