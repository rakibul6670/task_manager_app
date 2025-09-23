import 'package:flutter/material.dart';

class TaskCountByStatusCard extends StatelessWidget {
  final String title;
  final int count;
  final int hexColor;

  const TaskCountByStatusCard({
    super.key,
    required this.title,
    required this.count,
    required this.hexColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(hexColor),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(title, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
