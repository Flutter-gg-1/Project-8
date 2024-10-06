class Profile {
  String? id;
  String name;
  String email;
  String phone;
  String role;
  String? avatarUrl;
  String? password;
  String? createdAt;
  String? externalId;

  Profile({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role = 'customer',
    this.avatarUrl,
    this.password,
    this.createdAt,
    this.externalId,
  });

  // Factory constructor to create a Profile from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: json['created_at'] as String?,
      externalId: json['external_id'] as String?,
    );
  }

  // Method to convert Profile to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'avatar_url': avatarUrl,
      'created_at': createdAt,
      'external_id': externalId,
    };
  }
}

enum UserRole { customer, employee, admin }
