import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import '../widgets/show_snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  //=================== Task Loading progress ============
  bool progressTaskLoadProgress = false;

  //================================
  List<TaskModel> progressTaskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _getProgressTask(),
        child: Visibility(
          visible: progressTaskLoadProgress == false,
          replacement: LoadingProgressIndicator(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:  progressTaskList.isEmpty
                ? Center(child: Text("No Task Found !"))
                : ListView.builder(
              itemCount: progressTaskList.length,
              itemBuilder: (context, index) {
                final progress = progressTaskList[index];

                return TaskCard(
                        title: progress.title,
                        subTitle: progress.description,
                        date: progress.createdDate,
                        taskStatus: progress.status,
                        id: progress.id,
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  //======================== Get Progress Task ====================
  Future<void> _getProgressTask() async {
    //================== Progress start ==============
    progressTaskLoadProgress = true;
    setState(() {});

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.progressTaskUrl,
    );

    //================== Progress Off ==============
    progressTaskLoadProgress = false;
    setState(() {});

    if (response.statusCode == 200 && response.isSuccess) {
      final dataList = response.responseBody["data"] as List<dynamic>;

      //--------------taskStatuslist e data add----------
      progressTaskList = dataList
          .map((data) => TaskModel.fromJson(data))
          .toList();

      ShowSnackBarMessage.successMessage(
        context,
        "Successfully progress task loaded",
      );
    } else {
      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }


  }
}
