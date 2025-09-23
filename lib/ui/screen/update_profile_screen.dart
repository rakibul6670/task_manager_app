import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/t_m_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  //-------------------form Key ------------------
  final _formKey = GlobalKey<FormState>();

  //----------------------Form Field Controller --------------
  final TextEditingController _emailUpdateController = TextEditingController();
  final TextEditingController _firstNameUpdateController =
      TextEditingController();
  final TextEditingController _lastNameUpdateController =
      TextEditingController();
  final TextEditingController _phoneUpdateController = TextEditingController();
  final TextEditingController _passwordUpdateController =
      TextEditingController();

  //-------------------Image picked instance -----------
  final ImagePicker _imagePick = ImagePicker();
  String _imagePath = "No Selected Image";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      //===================AppBar Section =================
      appBar: TMAppBar(isUpdateProfileScreen: true),

      //=======================Update Profile Section ============
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  //------------------------Title -------------------
                  Text("Update Profile", style: textTheme.titleLarge),
                  SizedBox(height: 16),

                  //--------------------Image picker ------------------
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        GestureDetector(
                          onTap: _getImage,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                              ),
                            ),
                            child: Text(
                              "Image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _imagePath,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),

                  //-------------------Email Update  field -------------
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    //validator: ,
                    controller: _emailUpdateController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 8),

                  //-------------------First Name Update field -------------
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    //validator: ,
                    controller: _firstNameUpdateController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 8),

                  //-------------------Last Name Update Text field -------------
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    //validator: ,
                    controller: _lastNameUpdateController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 8),

                  //-------------------Mobile Update Text field -------------
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    //validator: ,
                    controller: _emailUpdateController,
                    decoration: InputDecoration(
                      hintText: "Mobile",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 8),

                  //------------------Password Update Text field -------------
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    //validator: ,
                    controller: _passwordUpdateController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 18),
                  //-------------------Update Profile Button ---------
                  FilledButton(onPressed: () {}, child: Text("Update Profile")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //-----------------Image picker ---------------
  Future<void> _getImage() async {
    final XFile? imageFile = await _imagePick.pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile != null) {
      _imagePath = imageFile.path;
      setState(() {});
    }
  }

  //----------------Dispose all Controller ---------------
  @override
  void dispose() {
    _emailUpdateController.dispose();
    _firstNameUpdateController.dispose();
    _lastNameUpdateController.dispose();
    _phoneUpdateController.dispose();
    _passwordUpdateController.dispose();

    super.dispose();
  }
}
