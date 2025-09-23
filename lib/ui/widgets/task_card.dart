import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {

  final String title;
  final String subTitle;
  final String date;
  final VoidCallback deleteTask;
  final VoidCallback editTask;
  final String taskStatus;

  const TaskCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.deleteTask,
    required this.editTask,
    required this.taskStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //---------------------------Title ----------------------
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //--------------------SubTitle ------------------------------
            Text(subTitle),

            //----------------------Date -------------------------------
            Text(date),
            Row(
              children: [
                //-------------------New task text-----------------------------
                Chip(
                  label: Text(taskStatus),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: taskStatus == "New"? Colors.blue:
                  taskStatus == "Completed"? Colors.green:
                  taskStatus == "Cancelled"? Colors.red:Colors.purple,
                ),

                Spacer(),

                //-------------------Edit Button For Task Edit  ---------------
                IconButton(
                  onPressed: editTask,
                  icon: Icon(Icons.edit, color: Colors.green),
                ),

                //----------------------Delete Button For Task Delete ------------
                IconButton(
                  onPressed: deleteTask,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
