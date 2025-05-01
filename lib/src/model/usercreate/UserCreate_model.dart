class UserModel {
  final String name;
  final String email;
  final String dateOfBirth;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.password,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      password: json['password'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'password': password,
    };
  }
}
