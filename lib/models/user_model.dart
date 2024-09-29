class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String imageUrl;

  UserModel(
      {required this.userId,
      required this.name,
      required this.email,
      required this.phone,
      required this.role,
      required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['user_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        role: json['role'] ?? 'customer',
        imageUrl: json['image_url'] ?? 'assets/pfp.png');
  }

  toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'image_url': imageUrl
    };
  }
}
