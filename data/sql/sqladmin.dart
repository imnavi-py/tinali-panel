class User {
  late final int id;
  final String name;
  final String lastName;
  final bool fullControl;
  final String password;
  final String username;
  final String unit;

  User({
    this.id = 0,
    required this.name,
    required this.lastName,
    required this.fullControl,
    required this.password,
    required this.username,
    required this.unit,
  });

  // اضافه کردن متد toMap
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'fullControl': fullControl ? 1 : 0, // یا fullControl.toString()
        'password': password,
        'username': username,
        'unit': unit,
      };

  // اضافه کردن متد fromMap (از کامنت قبلی کپی کنید)
  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'] as int,
        name: map['name'] as String,
        lastName: map['lastName'] as String,
        fullControl:
            map['fullControl'] == 1, // یا bool.fromInt(map['fullControl'])
        password: map['password'] as String,
        username: map['username'] as String,
        unit: map['unit'] as String,
      );
}
