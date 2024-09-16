const String tableUser = 'userData';

class UserFields {
  static final List<String> values = [
    id,
    username,
    email,
    number,
    pass,
  ];

  static const String id = '_id';
  static const String username = 'username';
  static const String email = 'email';
  static const String number = 'number';
  static const String pass = 'pass';
}

class UserData {
  final int? id;
  final String username;
  final String email;
  final int number;
  final String pass;

  UserData({
    this.id,
    required this.username,
    required this.email,
    required this.number,
    required this.pass,
  });

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.username: username,
        UserFields.email: email,
        UserFields.number: number,
        UserFields.pass: pass,
      };

  static UserData fromJson(Map<String, Object?> json) => UserData(
        id: json[UserFields.id] as int?,
        username: json[UserFields.username] as String,
        email: json[UserFields.email] as String,
        number: json[UserFields.number] as int,
        pass: json[UserFields.pass] as String,
      );

  UserData copy({
    int? id,
    String? username,
    String? email,
    int? number,
    String? pass,
  }) =>
      UserData(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        number: number ?? this.number,
        pass: pass ?? this.pass,
      );
}
