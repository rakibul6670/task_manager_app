class Urls {
  static final String _baseUrl = "http://35.73.30.144:2005/api/v1";

  static final String signUpUrl = "$_baseUrl/Registration";
  static final String loginUrl = "$_baseUrl/Login";
  static final String createTaskUrl = "$_baseUrl/CreateTask";

  static final String taskStatusCountUrl = "$_baseUrl/taskStatusCount";
  static final String newTaskUrl = "$_baseUrl/listTaskByStatus/New";

  static String updateTaskStatusUrl (String id,String newStatus) => "$_baseUrl/$id/$newStatus";

}
