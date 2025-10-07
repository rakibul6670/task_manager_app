import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/show_snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }

  //===================== Completed Task Progress ===================
  bool completedTaskLoadProgress = false;

  //=================== Completed Task List ====================
  List<TaskModel> completedTaskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: ()=> _getCompletedTask(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Visibility(
            visible: completedTaskLoadProgress == false,
            replacement: LoadingProgressIndicator(),
            child: completedTaskList.isEmpty
                ? Center(child: Text("No Task Found !"))
                : ListView.builder(
                    itemCount: completedTaskList.length,
                    itemBuilder: (context, index) {
                      final completed = completedTaskList[index];
                      return TaskCard(
                        title: completed.title,
                        subTitle: completed.description,
                        date: completed.createdDate,
                        taskStatus: completed.status,
                        id: completed.id,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  //======================== Get Complete Task ====================
  Future<void> _getCompletedTask() async {
    //================== Progress start ==============
    completedTaskLoadProgress = true;
    setState(() {});

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.completedTaskSUrl,
    );

    if (response.statusCode == 200 && response.isSuccess) {
      final dataList = response.responseBody["data"] as List<dynamic>;

      //--------------taskStatuslist e data add----------
      completedTaskList = dataList
          .map((data) => TaskModel.fromJson(data))
          .toList();

      ShowSnackBarMessage.successMessage(
        context,
        "Successfully Completed task loaded",
      );
    } else {
      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }

    //================== Progress Off ==============
    completedTaskLoadProgress = false;
    setState(() {});
  }
}
