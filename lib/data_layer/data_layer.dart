import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:onze_cafe/models/cart_model.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/models/order_model.dart';
import 'package:onze_cafe/models/user_model.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  String? token;
  UserModel? user;
  OrderModel? order;
  List<ItemModel> items = [];
  List<ItemModel> allItems = [];
  CartModel cart = CartModel();

  final box = GetStorage();

  DataLayer() {
    loadData();
    fetchOrder();
  }

  saveAuth({required String token, required Map<String, dynamic> user}) async {
    await box.write('auth', token);
    await box.write('user', user);
    await loadData();
  }

  loggedIn() {
    if (box.hasData('auth')) {
      return true;
    }
    return false;
  }

  logout() async {
    box.erase();
    token = null;
    user = null;
  }

  loadData() async {
    if (box.hasData('auth')) {
      token = box.read('auth');
    }

    if (box.hasData('user')) {
      user = UserModel.fromJson(Map<String, dynamic>.from(box.read('user')));
    }
  }

  fetchOrder() async {
    if (user != null) {
      final response = await supabase
          .from('orders')
          .select()
          .eq('user_id', user!.userId)
          .maybeSingle();

      log('${response}');

      if (response == null) {
        final insertResponse = await supabase
            .from('orders')
            .insert({
              'user_id': user?.userId,
              'status': 'incomplete',
              'total_price': 0
            })
            .select()
            .single();
        if (!box.hasData('order')) {
          await box.write('order', insertResponse);
        }
        order = OrderModel.fromJson(insertResponse);
      } else {
        if (!box.hasData('order')) {
          await box.write('order', response);
        }
        order = OrderModel.fromJson(response);
      }
    }

    final allItemsList = await supabase.from("item").select("*");
    for (var item in allItemsList) {
      allItems.add(ItemModel.fromJson(item));
    }
  }

  Future<Map<String, dynamic>> getUserByEmail({required String email}) async {
    final response =
        await supabase.from('app_user').select().eq('email', email).single();

    return response;
  }

  addItem({required OrderItemModel item}) async {
    bool itemExists = false;
    
    for (var e in cart.items) {
      if (e.itemId == item.itemId) {
        e.quantity++; // Increase quantity if item exists
        itemExists = true;
        break;
      }
    }
    
    if (!itemExists) {
      cart.addItem(item: item); // Add new item if it doesn't exist
    }
  }
  Future<List<ItemModel>> getItemsByType(String itemType) async {
    // Map of valid item types that match your database enum values
    const itemTypeMap = {
      "classicCoffee": "Classic Coffee Drinks",
      "coldDrinks": "Cold Drinks",
      "dripCoffee": "Drip Coffee",
      "teaDrinks": "Tea Drinks",
      "water": "Water",
      "dessert": "Dessert"
    };

    // Check if the passed itemType is valid
    if (!itemTypeMap.containsKey(itemType)) {
      throw Exception('Invalid item_type: $itemType');
    }

    // Get the actual enum value from the map
    final dbItemType = itemTypeMap[itemType];

    // Fetch the products from Supabase using the correct enum value
    final response = await Supabase.instance.client
        .from("item")
        .select("*")
        .eq("item_type", dbItemType!);

    if (response == null || response.isEmpty) {
      throw Exception('No products found');
    }

    // Convert the response data to List<ItemModel>
    List<ItemModel> itemsList = (response as List)
        .map((itemData) => ItemModel.fromJson(itemData))
        .toList();

    items = itemsList;
    return itemsList;
  }
}
