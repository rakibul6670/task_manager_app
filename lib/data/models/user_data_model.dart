class UserDataModel {
 final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
//final String createdDate;

  //-------------------Full Name -----------
  String get fullName {
    return "$firstName $lastName";
  }

  UserDataModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    //required this.createdDate,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["_id"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      mobile: json["mobile"],
      //createdDate: json["createdDate"],
    );
  }

  Map<String, dynamic> toJson() {

    return {
      "_id" :id,
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
    };
  }

}
