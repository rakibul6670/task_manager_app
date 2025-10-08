import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/show_snack_bar_message.dart';

class TaskCard extends StatefulWidget {
  final String id;
  final String title;
  final String subTitle;
  final String date;

  final String taskStatus;

  const TaskCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.taskStatus,
    required this.id,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  //==================== Status change progress =======================
  bool statusChangeProgress = false;
//======================= Delete Task Progress=====================
 bool deleteTaskProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //---------------------------Title ----------------------
        title: Text(widget.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //--------------------SubTitle ------------------------------
            Text(widget.subTitle),

            //----------------------Date -------------------------------
            Text(widget.date),
            Row(
              children: [
                //-------------------New task text-----------------------------
                Chip(
                  label: Text(widget.taskStatus),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: widget.taskStatus == "New"
                      ? Colors.blue
                      : widget.taskStatus == "Completed"
                      ? Colors.green
                      : widget.taskStatus == "Cancelled"
                      ? Colors.red
                      : Colors.purple,
                ),

                Spacer(),

                //-------------------Edit Button For Task Edit  ---------------
                Visibility(
                  visible: statusChangeProgress == false,
                  replacement: LoadingProgressIndicator(),
                  child: IconButton(
                    onPressed:

                        () => changeStatusDialog(context, widget.taskStatus),
                    icon: Icon(Icons.edit, color: Colors.green),
                  ),
                ),

                //----------------------Delete Button For Task Delete ------------
                Visibility(
                  visible: deleteTaskProgress==false,
                  replacement: LoadingProgressIndicator(),
                  child: IconButton(
                    onPressed: () async{
                      await deleteTask(widget.id);
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  //====================== Status change dialog=================================

 Future<void> changeStatusDialog(context, String taskStatus) async {
   return showDialog(
     barrierDismissible: false,
     useSafeArea: true,
     context: context,
     builder: (context) {
       return AlertDialog(
         title: Text("Update Task Status"),
         elevation: 4,
         content: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             //---------------------New status--------
             ListTile(
               onTap: () {
                 changeStatus("New");

               },
               title: Text("New"),
               trailing: taskStatus == "New"
                   ? Icon(Icons.check, color: Colors.green)
                   : null,
             ),

             //---------------------Progress status--------
             ListTile(
               onTap: () {
                 changeStatus("Progress");
                 setState(() {

                 });
               },
               title: Text("Progress"),
               trailing: taskStatus == "Progress"
                   ? Icon(Icons.check, color: Colors.green)
                   : null,
             ),

             //---------------------Completed status--------
             ListTile(
               onTap: () {
                 changeStatus("Completed");
               },
               title: Text("Completed"),
               trailing: taskStatus == "Completed"
                   ? Icon(Icons.check, color: Colors.green)
                   : null,
             ),

             //---------------------Progress status--------
             ListTile(
               onTap: () {
                 changeStatus("Cancelled");
               },
               title: Text("Cancelled"),
               trailing: taskStatus == "Cancelled"
                   ? Icon(Icons.check, color: Colors.green)
                   : null,
             ),
           ],
         ),
         actionsAlignment: MainAxisAlignment.center,

       );
     },
   );
 }


 //============================== Change Task Status ================================
  Future<void> changeStatus(String taskStatus) async {

    if(taskStatus == widget.taskStatus){
      Navigator.pop(context);
      return ;
    }

    //==================== status change progress show===
    statusChangeProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.id, taskStatus),
    );

    //==================== status change progress show
    statusChangeProgress = false;
    setState(() {});


    if(response.isSuccess && response.statusCode == 200){
      ShowSnackBarMessage.successMessage(context, "Status change successful");
      Navigator.pop(context);
    }
    else{
      ShowSnackBarMessage.failedMessage(context, "Status change failed");
    }




  }


  //============================== Delete Task ================================
  Future<void> deleteTask(String id) async {


    //==================== status change progress show===
    deleteTaskProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.deleteTaskUrl(id),
    );

    //==================== status change progress show
    deleteTaskProgress = false;
    setState(() {});


    if(response.isSuccess && response.statusCode == 200){
      ShowSnackBarMessage.successMessage(context, "task delete successful");

    }
    else{
      ShowSnackBarMessage.failedMessage(context, "task delete failed");
    }




  }
}
