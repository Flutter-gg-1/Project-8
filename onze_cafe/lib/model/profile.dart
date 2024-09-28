class Profile {
  String id;
  String name;
  String email;
  String phone;
  String? password;
  String? createdAt;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.password,
    this.createdAt,
  });
}
