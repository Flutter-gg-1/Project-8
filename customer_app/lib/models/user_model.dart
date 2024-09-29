class UserModel {
  UserModel({
    required this.customerId,
    required this.email,
    required this.firstName,
    required this.lastName,
  });
  late final String customerId;
  late final String email;
  late final String firstName;
  late final String lastName;
  
  UserModel.fromJson(Map<String, dynamic> json){
    customerId = json['customerId'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerId'] = customerId;
    _data['email'] = email;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    return _data;
  }
}