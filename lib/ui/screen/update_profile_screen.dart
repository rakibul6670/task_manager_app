
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/user_data_model.dart';
import 'package:task_manager_app/ui/controllers/auth_controllers.dart';
import 'package:task_manager_app/ui/utils/validator.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/t_m_app_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/show_snack_bar_message.dart';

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

  double imageSizeInMB = 0;

  //-------------------- Progress ------------
  bool _updateProfileProgress = false;

  //----------------------- init state ----------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(AuthControllers.userModel != null){
      UserDataModel? model = AuthControllers.userModel;

      _emailUpdateController.text= model!.email;
      _firstNameUpdateController.text= model.firstName;
      _lastNameUpdateController.text= model.lastName;
      _phoneUpdateController.text= model.mobile;
    }
    // _emailUpdateController.text
  }

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
                    enabled: false,
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
                    validator: (value)=>
                      Validator.validateName(value, fieldName: "First name"),
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
                    validator: (value)=>
                        Validator.validateName(value, fieldName: "Last name"),
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
                    validator: Validator.validatePhone,
                    controller: _phoneUpdateController,
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
                    validator: (value){
                      if(value== null || value.isEmpty){
                        return "Password can't be empty";
                      }

                    },
                    controller: _passwordUpdateController,
                    decoration: InputDecoration(
                      hintText: "Password (optional)",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 18),
                  //-------------------Update Profile Button ---------
                  Visibility(
                    visible: _updateProfileProgress == false,
                    replacement: LoadingProgressIndicator(),
                    child: FilledButton(onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _updateProfile();
                      }
                    }, child: Text("Update Profile")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  //==================== Profile update ===================
  Future<void> _updateProfile() async {
    //------------------When click this button then show circular indicator -----------
    _updateProfileProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email":_emailUpdateController.text.trim(),
      "firstName":_firstNameUpdateController.text.trim(),
      "lastName":_lastNameUpdateController.text.trim(),

      // "email":"email@gmail.com",
      // "firstName":"a",
      // "lastName":"a",
      // "mobile":"01716874981",
      // "password":"123456",
      // "photo":""

    };

    if(_passwordUpdateController.text.isNotEmpty){
      requestBody["password"]=_passwordUpdateController.text.trim();
    }

    // if (_imagePath.isNotEmpty) {
    //   List<int> bytes =  await File(_imagePath).readAsBytes();;
    //   final encodedPhoto = jsonEncode(bytes);
    //  // requestBody['photo'] = encodedPhoto;
    // }


    //-------------------Server e response sent -------------
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.updateProfile,
      requestBody: requestBody,
    );

    //------------------after response circular indicator off -----------
    _updateProfileProgress = false;
    setState(() {});

    if (response.isSuccess && response.responseBody["status"] == "success") {
      //------------When Profile success then clear text form field---------
      // _clearTextField();
      //------------When profile update success then show successful snackbar ---------
      ShowSnackBarMessage.successMessage(context, "Profile update success");

      UserDataModel model = UserDataModel.fromJson(
        response.responseBody["data"],
      );


      //---------------------Local storage e data store ----------------

      await AuthControllers.updateProfileData(model);

      setState(() {

      });


    } else {
      //------------When task add success then show failed snackbar ---------
      //-------and show failed message-------
      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }
  }

  Future<void> _getImage() async {
    final XFile? imageFile = await _imagePick.pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile != null) {
      final file = File(imageFile.path);
      final int fileSize = await file.length();
      final double imageSizeInMB = fileSize / (1024 * 1024);

      if (imageSizeInMB > 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image size should be less than 2 MB")),
        );
        return; // Stop execution if image is too large
      }

      _imagePath = imageFile.path;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No image selected")),
      );
    }
  }

  //---------------- clear form field -------------------
  void _clearTextField(){
    _emailUpdateController.clear();
    _firstNameUpdateController.clear();
    _lastNameUpdateController.clear();
    _phoneUpdateController.clear();
    _passwordUpdateController.clear();
  }


  //------------------ dispose controller ------------------
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
