
class GroupInviteUser {
  String? _status;
  Data? _data;

  GroupInviteUser({String? status, Data? data}) {
    if (status != null) {
      this._status = status;
    }
    if (data != null) {
      this._data = data;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  GroupInviteUser.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Users>? _users;

  Data({List<Users>? users}) {
    if (users != null) {
      this._users = users;
    }
  }

  List<Users>? get users => _users;
  set users(List<Users>? users) => _users = users;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      _users = <Users>[];
      json['users'].forEach((v) {
        _users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._users != null) {
      data['users'] = this._users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? _userId;
  String? _name;
  String? _email;
  String? _role;
  String? _dateOfBirth;
  String? _createdAt;

  Users(
      {String? userId,
        String? name,
        String? email,
        String? role,
        String? dateOfBirth,
        String? createdAt}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (role != null) {
      this._role = role;
    }
    if (dateOfBirth != null) {
      this._dateOfBirth = dateOfBirth;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
  }

  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(String? dateOfBirth) => _dateOfBirth = dateOfBirth;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  Users.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _name = json['name'];
    _email = json['email'];
    _role = json['role'];
    _dateOfBirth = json['dateOfBirth'];
    _createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['userId'] = this._userId;
    data['name'] = this._name;
    data['email'] = this._email;
    data['role'] = this._role;
    data['dateOfBirth'] = this._dateOfBirth;
    data['createdAt'] = this._createdAt;
    return data;
  }
}