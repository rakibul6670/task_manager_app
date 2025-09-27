class UserDataModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String createdDate;

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
    required this.createdDate,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["_id"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      mobile: json["mobile"],
      createdDate: json["createdDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      createdDate: createdDate,
    };
  }

  // "status": "success",
  //     "data": {
  //         "_id": "68d7fcfb27e751dc7aeb0237",
  //         "email": "rakibul1234@gmail.com",
  //         "firstName": "Rakibul",
  //         "lastName": "Hossain",
  //         "mobile": "016765656543",
  //         "createdDate": "2025-09-24T06:37:43.773Z"
  //     },
  //     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTkwNzM0NDcsImRhdGEiOiJyYWtpYnVsMTIzNEBnbWFpbC5jb20iLCJpYXQiOjE3NTg5ODcwNDd9.FR2RdYoc61aFev6dpdm8h0E9Bbof7c6DdyINfS6ZI4c"
  // }
}
