import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/show_snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCancelledTask();
  }

  //=================== Cancelled Task Load Progress =========
  bool cancelledTaskLoadProgress = false;

  //==================== Cancelled Progress List =============
  List<TaskModel> cancelledTaskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: ()=> _getCancelledTask(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Visibility(
            visible: cancelledTaskLoadProgress == false,
            replacement: LoadingProgressIndicator(),
            child: cancelledTaskList.isEmpty
                ? Center(child: Text("No Task Found !"))
                : ListView.builder(
                    itemCount: cancelledTaskList.length,
                    itemBuilder: (context, index) {
                      final cancelled = cancelledTaskList[index];
                      return TaskCard(
                        title: cancelled.title,
                        subTitle: cancelled.description,
                        date: cancelled.createdDate,
                        taskStatus: cancelled.status,
                        id: cancelled.id,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  //=========================== Get Cancelled Task ========================
  Future<void> _getCancelledTask() async {
    //================== Progress start ==============
    cancelledTaskLoadProgress = true;
    setState(() {});

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.cancelledTasksUrl,
    );

    if (response.statusCode == 200 && response.isSuccess) {
      final dataList = response.responseBody["data"] as List<dynamic>;

      //--------------task Status list e data add----------
      cancelledTaskList = dataList
          .map((data) => TaskModel.fromJson(data))
          .toList();

      ShowSnackBarMessage.successMessage(
        context,
        "Successfully Cancelled task loaded",
      );
    } else {
      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }

    //================== Progress Off ==============
    cancelledTaskLoadProgress = false;
    setState(() {});
  }
}
