class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
    };
  }
}
