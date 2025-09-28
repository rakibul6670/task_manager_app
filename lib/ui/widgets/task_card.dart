import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/show_change_status_dialog.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final String date;
  final VoidCallback deleteTask;
  final VoidCallback? editTask;
  final String taskStatus;

  const TaskCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.deleteTask,
    this.editTask,
    required this.taskStatus,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  //==================== Status change progress =======================
  bool statusChangeProgress = false;

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
                IconButton(
                  onPressed:
                      widget.editTask ??
                      () => changeStatusDialog(context, widget.taskStatus),
                  icon: Icon(Icons.edit, color: Colors.green),
                ),

                //----------------------Delete Button For Task Delete ------------
                IconButton(
                  onPressed: widget.deleteTask,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //============================== Change Task Status ================================
  Future<void> _changeStatus(String taskStatus) async {
    statusChangeProgress = true;
    setState(() {});

    // final ApiResponse response = await ApiCaller.getRequest(
    //   url: Urls.updateTaskStatusUrl(id, newStatus),
    // );


  }
}
