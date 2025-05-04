class Users {
  final String? name;
  final String? email;

  Users({this.name, this.email});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      email: json['email'],
    );
  }
}
