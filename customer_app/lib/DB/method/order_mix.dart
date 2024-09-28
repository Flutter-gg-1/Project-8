import 'dart:developer';

import 'package:customer_app/DB/super.dart';

mixin OrderMix on Super{

  Future<void> getMenu()async{
    try {
      final x = await supabase.from('product').select('*');
      log('$x');
    } catch (e) {
      log('$e');
    }
  }
}