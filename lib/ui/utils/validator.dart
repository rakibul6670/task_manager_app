class Validator{

//===============================Name (first /last) Validate====================
 static String? validateName(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "$fieldName must contain only letters";
    }
    if (value.length < 2) {
      return "$fieldName must be at least 2 characters";
    }
    return null;
  }

//===============================Email Validate==================================
  static String? validateEmail(String? email){
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(email == null || email.trim().isEmpty){
      return "Please enter email";
    }
    else if(!emailRegex.hasMatch(email) ){
      return "Please enter valid email";

    }
    return null;
  }
//=============================== Phone Validate==================================
 static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Phone number must contain only digits";
    }
    if (value.length < 10) {
      return "Phone number must be at least 10 digits";
    }
    return null;
  }
//=============================== Password Validate==================================
 static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$').hasMatch(value)) {
      return "Password must contain letters and numbers";
    }
    return null;
  }




}