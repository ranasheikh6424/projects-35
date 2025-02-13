class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  static const String registrationUrl = '$_baseUrl/registration';
  static const String loginUrl = '$_baseUrl/login';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String taskCountByStatusUrl = '$_baseUrl/taskStatusCount';

  static String taskListByStatusUrl(String status) =>
      '$_baseUrl/listTaskByStatus/$status';
  static String recoverVerifyemail(Email) =>
      '$_baseUrl/RecoverVerifyEmail/$Email';
  static String recoverVerifyotp(email, otp) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$otp';

  static String ResetPassword() => '$_baseUrl/RecoverResetPass';
  static String DeleteTask(taskId) => '$_baseUrl/deleteTask/$taskId';
  static String UpdateTask(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static const String updateProfile = '$_baseUrl/profileUpdate';
}
