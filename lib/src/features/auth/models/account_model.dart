class AccountModel {
  final String name;
  final String email;
  final String token;

  AccountModel({
    required this.name,
    required this.email,
    required this.token,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
}
