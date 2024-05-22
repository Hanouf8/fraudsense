class UserModel {
  final String userName;
  final String email;
  final String surName;

  const UserModel({
    required this.userName,
    required this.email,
    required this.surName,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'surName': surName,
      };
}
