import 'package:flutter/material.dart';
import '../widgets/task_card.dart';



class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

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
              deleteTask: () {  },
              editTask: () {  },
              taskStatus: 'Progress',
            );
          },
        ),
      ),
    );
  }
}


