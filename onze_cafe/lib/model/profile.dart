class Profile {
  String? id;
  String name;
  String email;
  String phone;
  String? avatarUrl;
  String? password;
  String? createdAt;

  Profile({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.password,
    this.createdAt,
  });
}
