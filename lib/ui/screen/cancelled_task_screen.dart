import 'package:flutter/material.dart';
import '../widgets/task_card.dart';



class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:  ListView.builder(
          itemCount: 25,
          itemBuilder: (context, index) {
            return TaskCard(
              title: 'Title $index',
              subTitle: 'Task Subtitle $index',
              date: '21/09/25',
              deleteTask: () {  },
              editTask: () {  },
              taskStatus: 'Cancelled',
            );
          },
        ),
      ),
    );
  }
}


