import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/show_snack_bar_message.dart';
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

  bool _taskAddProgressIndicator = false;

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
                   autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Enter your task title";
                    }
                    return null;
                  },
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
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Enter your task descrioption";
                    }
                    return null;
                  },
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
                Visibility(
                  visible: _taskAddProgressIndicator == false,
                  replacement: LoadingProgressIndicator(),
                  child: FilledButton(
                    onPressed: _onTapAddTaskButton,
                    child: Text("Add Task"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===================ValidateWithAddTask===================
  Future<void> _onTapAddTaskButton() async {
    if (_formKey.currentState!.validate()) {
      await _addTask();
    }
  }


  //========================Add Task =============================
  Future<void> _addTask() async {
    //------------------When click this button then show circular indicator -----------
    _taskAddProgressIndicator = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _taskAddTitleController.text.trim(),
      "description": _taskAddDescriptionController.text.trim(),
      "status": "New",
    };
    //-------------------Server e response sent -------------
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.createTaskUrl,
      requestBody: requestBody,
    );

    //------------------after response circular indicator off -----------
    _taskAddProgressIndicator = false;
    setState(() {});

    if (response.isSuccess && response.responseBody["status"] == "success") {
      //------------When task add success then clear text form field---------
      _clearTextField();
       //------------When task add success then show successful snackbar ---------
      ShowSnackBarMessage.successMessage(context, "Task Add Successful");


    } else {
           //------------When task add success then show failed snackbar ---------
           //-------and show failed message-------
      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }
  }


  //=================Clear TextForm field==================
  void _clearTextField() {
    _taskAddTitleController.clear();
    _taskAddDescriptionController.clear();
  }


  //=====================Dispose all Controller ====================
  @override
  void dispose() {
    _taskAddTitleController.dispose();
    _taskAddDescriptionController.dispose();
    super.dispose();
  }
}
