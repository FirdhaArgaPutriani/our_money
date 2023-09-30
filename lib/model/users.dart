class Users {
  int id;
  String name;
  String username;
  String password;

  Users({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
    };
  }
}
