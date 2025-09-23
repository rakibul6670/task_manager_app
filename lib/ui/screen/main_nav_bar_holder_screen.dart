import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screen/add_task_screen.dart';
import 'package:task_manager_app/ui/screen/cancelled_task_screen.dart';
import 'package:task_manager_app/ui/screen/completed_task_screen.dart';
import 'package:task_manager_app/ui/screen/progress_task_screen.dart';
import 'package:task_manager_app/ui/widgets/t_m_app_bar.dart';

import 'new_task_screen.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  //-------------------------Navigation bar selected index -------------
  int selectedIndex = 0;

  //---------------------- Screen List -----------------
  List<Widget> screen = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      //================================AppBar Section =========================
      appBar: TMAppBar(),

      //==============================Body Section =============================
      body: SafeArea(child: screen[selectedIndex]),

      //==================== floating Action Button ====================
      floatingActionButton: Visibility(
        visible: selectedIndex == 0,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: _onTapAddTaskButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),

      //============================Navigation Bar Section======================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.fiber_new), label: "New"),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: "Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Completed",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Cancelled"),
        ],
      ),
    );
  }

  //--------------------Go to Add task Screen ------------
  void _onTapAddTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );
  }
}
