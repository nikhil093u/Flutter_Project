import 'dart:convert';

class AuthUser {
  final int userId;
  final String name;
  final String email;
  final String group;
  final int companyId;
  final String company;
  final bool isDistributor;
  final int? distributorId;
  final String accessToken;

  AuthUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.group,
    required this.companyId,
    required this.company,
    required this.isDistributor,
    required this.distributorId,
    required this.accessToken,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      group: json['group'],
      companyId: json['company_id'],
      company: json['company'],
      isDistributor: json['is_distributor'] ?? false,
      distributorId: json['distributor_id'],
      accessToken: json['access_token'],
    );
  }
}
String userToJson(AuthUser user) => jsonEncode({
  "user_id": user.userId,
  "name": user.name,
  "email": user.email,
  "group": user.group,
  "company_id": user.companyId,
  "company": user.company,
  "is_distributor": user.isDistributor,
  "distributor_id": user.distributorId,
  "access_token": user.accessToken,
});

AuthUser authUserFromJson(String source) =>
    AuthUser.fromJson(jsonDecode(source));

