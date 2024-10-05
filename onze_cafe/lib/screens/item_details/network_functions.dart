import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/model/enums/coffee_strength.dart';
import 'package:onze_cafe/model/enums/cup_size.dart';
import 'package:onze_cafe/model/enums/milk_options.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

import '../../model/cart_Item.dart';
import '../../model/menu_item.dart';
import '../../supabase/client/supabase_mgr.dart';
import '../../supabase/supabase_cart.dart';

extension NetworkFunctions on ItemDetailsCubit {
  Future addToCart(BuildContext context, MenuItem item) async {
    var cartItem = CartItem(
        userId: SupabaseMgr.shared.currentUser?.id ?? '',
        menuItemId: item.id!,
        quantity: quantity,
        size: selectedSize.strValue(),
        coffeeStrength: selectedStrength.strValue(),
        milkOption: milkOptions[milkSlider].strValue());
    try {
      await SupabaseCart.insertCartItem(cartItem: cartItem);
      if (context.mounted) navigateBack(context);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), AnimatedSnackBarType.error);
      }
    }
  }
}
