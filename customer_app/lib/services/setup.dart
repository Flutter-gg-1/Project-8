import 'package:customer_app/data_layer/product_layer.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
final productLocator = GetIt.instance;
Future<void> setup() async {
  await GetStorage.init();
  productLocator.registerSingleton<ProductLayer>(ProductLayer());

}