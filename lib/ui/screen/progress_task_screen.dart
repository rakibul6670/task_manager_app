import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/show_snack_bar_message.dart';
import '../widgets/task_card.dart';



class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  //=============== Progress task list ========
  List progressTaskList = [];

//==================== Progress ============
bool progressTaskLoadingProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:  ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return TaskCard(
              title: 'Title $index',
              subTitle: 'Task Subtitle $index',
              date: '21/09/25',
              // deleteTask: () {  },
              // editTask: () {  },
              taskStatus: 'Progress', id: '',
            );
          },
        ),
      ),
    );
  }

 //===================== Get New Task ========================================
  Future<void> _getProgressTask() async {
    Logger logger = Logger();
    //======== Task Loading progress show ====
     progressTaskLoadingProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );

    logger.i("Task load: ${response.isSuccess}");

    //===========Task Loading progress off ========
     progressTaskLoadingProgress = false;
    setState(() {});

    if (response.isSuccess  && response.responseBody["status"] == "success") {
      final dataList = response.responseBody["data"] as List<dynamic>;

      progressTaskList = dataList.map((data) => TaskModel.fromJson(data)).toList();

      logger.i("task  list length: ${dataList.length}");

      logger.i("response body : ${response.responseBody["data"]}");
    } else {
      logger.e("Task load failed : ${response.errorMessage.toString()}");
      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }
  }

}


