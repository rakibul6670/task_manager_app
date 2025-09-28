import 'package:flutter/material.dart';

class TaskCountByStatusCard extends StatelessWidget {
  final String title;
  final int count;

  const TaskCountByStatusCard({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //-----------------------Card color -------------
      color: title == "New"
          ? Colors.blue
          : title == "Completed"
          ? Colors.green
          : title == "Cancelled"
          ? Colors.red
          : Colors.purple,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(7),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              "$count",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
