


import 'package:customer_app/DB/method/auth_mix.dart';
import 'package:customer_app/DB/method/cart_mix.dart';
import 'package:customer_app/DB/method/order_mix.dart';
import 'package:customer_app/DB/super.dart';

class SuperMain extends Super with AuthMix ,OrderMix , CartMix{}