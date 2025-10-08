import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/models/task_status_count_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/show_snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    getTaskStatusCount();
    _getAllNewTask();
  }

  //=========================Task status list ============
  List<TaskStatusCountModel> taskStatusList = [];

  //=================== Task status count progress ========
  bool taskStatusCountProgress = false;

  //=================== Task loading progress ========
  bool taskLoadingProgress = false;
  List<TaskModel> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: RefreshIndicator(
        onRefresh: () async{
          await getTaskStatusCount();
          await _getAllNewTask();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 15,
            children: [
              //-------------------Task Count Section -------------
              SizedBox(
                height: 90,
                child: Visibility(
                  visible: taskStatusCountProgress == false,
                  replacement: LoadingProgressIndicator(),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final count = taskStatusList[index];
                      return TaskCountByStatusCard(
                        title: count.id,
                        count: count.sum,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 4);
                    },
                    itemCount: taskStatusList.length,
                  ),
                ),
              ),

              //----------------ListTile card ---------------
              Expanded(
                child: Visibility(
                  visible: taskLoadingProgress == false,
                  replacement: LoadingProgressIndicator(),
                  child: taskList.isEmpty? Center(child: Text("No Task Found !")): ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      final task = taskList[index];

                      return TaskCard(
                        title: task.title,
                        subTitle: task.description,
                        date: task.createdDate.substring(0,10),


                        taskStatus: task.status,
                        id: task.id,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //======================== Task status Count data load ===================
  Future<void> getTaskStatusCount() async {
    //==================progress ON
    taskStatusCountProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );

    //====================progess OFF=======
    taskStatusCountProgress = false;
    setState(() {});

    if (response.isSuccess && response.responseBody["status"] == "success") {

      final dataList = response.responseBody["data"] as List<dynamic>;

      //--------------taskStatuslist e data add----------
      taskStatusList = dataList
          .map((data) => TaskStatusCountModel.fromJson(data))
          .toList();

      ShowSnackBarMessage.successMessage(
        context,
        "Successfully task status count data loaded",
      );
    } else {
      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }
  }

  //===================== Get New Task ========================================
  Future<void> _getAllNewTask() async {
    Logger logger = Logger();
    //=================== Task Loading progress show ========
    taskLoadingProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.newTaskUrl,
    );

    logger.i("Task load: ${response.isSuccess}");

    //=================== Task Loading progress off ========
    taskLoadingProgress = false;
    setState(() {});

    if (response.isSuccess  && response.responseBody["status"] == "success") {
      final dataList = response.responseBody["data"] as List<dynamic>;

      taskList = dataList.map((data) => TaskModel.fromJson(data)).toList();

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
