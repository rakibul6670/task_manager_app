
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/task_count_data.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';


class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 15,
          children: [
            //-------------------Task Count Section -------------
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final count =taskCountList[index];
                  return TaskCountByStatusCard(
                      title: count["title"],
                      count:count["count"],
                      hexColor: count["color"],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 4);
                },
                itemCount: 4,
              ),
            ),

            //----------------ListTile card ---------------
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(
                    title: 'Title $index',
                    subTitle: 'Task Subtitle $index',
                    date: '21/09/25',
                    deleteTask: () {  },
                    editTask: () {  },
                    taskStatus: 'New',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


