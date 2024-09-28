class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String role;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    this.role = 'customer',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['user_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        role: json['role'] ?? 'customer');
  }

  toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }
}
