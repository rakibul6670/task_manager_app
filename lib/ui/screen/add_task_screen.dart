import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/t_m_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //------------------Form key --------------
  final _formKey = GlobalKey<FormState>();

  //-----------------Form Field Controller ------------
  final TextEditingController _taskAddTitleController = TextEditingController();
  final TextEditingController _taskAddDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //----------------Text theme --------------
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      //============================AppBar Section ==============================
      appBar: TMAppBar(),

      //=======================Task Add Form Section ===========================
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                //---------------- Form Title-----------
                Text("Add New Task", style: textTheme.titleLarge),
                SizedBox(height: 16),

                //--------------------Task tile --------------
                TextFormField(
                  //validator: ,
                  controller: _taskAddTitleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Enter your task title",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),

                SizedBox(height: 8),
                //-----------------------Task Description -----------
                TextFormField(
                  //validator: ,
                  controller: _taskAddDescriptionController,
                  textInputAction: TextInputAction.next,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Enter your task description",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),

                SizedBox(height: 30),

                //----------------------Task Add Button -------------
                FilledButton(onPressed: () {}, child: Text("Add Task")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //=====================Dispose all Controller ====================
  @override
  void dispose() {
    _taskAddTitleController.dispose();
    _taskAddDescriptionController.dispose();
    super.dispose();
  }
}
