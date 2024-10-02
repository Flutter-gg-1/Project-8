import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

final productLocator = GetIt.instance;
final authLocator = GetIt.instance;
Future<void> setup() async {
  await GetStorage.init();
  productLocator.registerSingleton<ProductLayer>(ProductLayer());
  authLocator.registerSingleton<AuthLayer>(AuthLayer());
}
