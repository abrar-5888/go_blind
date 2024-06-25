class UsersModel {
  String? firebaseKey;
  String name;

  String phone;
  String email;
  String password;
  String pictureUrl;
  String language;
  bool deleted;
  String address;

  UsersModel({
    required this.language,
    this.firebaseKey,
    required this.pictureUrl,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.address,
    deleted,
  }) : deleted = deleted ?? false;

  static UsersModel fromJson(key, value) {
    return UsersModel(
      language: value['language'],
      firebaseKey: key,
      name: value['name'],
      phone: value['phone'],
      email: value['email'],
      password: value['password'],
      pictureUrl: value['pictureUrl'],
      deleted: value['deleted'],
      address: value['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "language": language,
        "email": email,
        "password": password,
        "pictureUrl": pictureUrl,
        "deleted": deleted,
        "address": address,
      };
}
