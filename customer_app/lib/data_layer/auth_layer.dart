


import 'package:customer_app/models/user_model.dart';

class AuthLayer {


  UserModel? user = UserModel(customerId: "929fc748-4578-414d-bc33-06bdbaad123a", email: "email", firstName: "firstName", lastName: "lastName");

  userGiveVal({required UserModel userModel}) {
    user = userModel;


  }
}