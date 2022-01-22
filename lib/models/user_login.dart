abstract class BaseModel {
  Map<String, dynamic> toMap();
}

class UserLogin extends BaseModel {
  String? email = "";
  String? phone;
  String? fullName;
  String? password;
  String? confirmPassword;
  String? birthday;
  String? avatar;

  // String get phone => _phone;
  // set phone(String val) => _phone = val.replaceAll(new RegExp(r'\s+'), '');

  UserLogin({
    this.phone = '',
    this.password = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'username': phone,
    };
  }

  Map<String, dynamic> toMapInit() {
    return {'user_id': '9', 'lang': 'VN'};
  }

  UserLogin.fromMap(dynamic map)
      : email = map['Email'],
        fullName = map['FullName'],
        birthday = map['BirthDay'],
        phone = map['phone'];
  UserLogin.fromMapInternal(Map<dynamic, dynamic> map)
      : email = map['email'],
        fullName = map['fullName'],
        birthday = map['birthday'],
        phone = map['phone'];
}

class Token extends BaseModel {
  String? authorization;

  // String get phone => _phone;
  // set phone(String val) => _phone = val.replaceAll(new RegExp(r'\s+'), '');

  Token(this.authorization);

  Token.fromMap(dynamic map) : authorization = map['data'];

  @override
  Map<String, dynamic> toMap() {
    // ignore: todo
    // TODO: implement toMap
    return {
      'authorization': authorization,
    };
  }
}
