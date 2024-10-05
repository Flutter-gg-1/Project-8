import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/screens/Order_Tracking/order_trcking.dart';
import 'package:onze_cafe/screens/cart_screen/cart_bloc/cart_bloc.dart';
import 'package:onze_cafe/screens/cart_screen/cart_item_card.dart';
import 'package:onze_cafe/services/setup.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => CartBloc()..add(CartLoadEvent()),
      child: Builder(builder: (context) {
        return BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartSuccessState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final bloc = context.read<CartBloc>();
            return Scaffold(
                backgroundColor: Color(0xffF8F8F8),
                appBar: AppBar(
                  backgroundColor: const Color(0xff74a0b2),
                  elevation: 0,
                  title: Text(
                    'Your Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text(
                                  'Do you want to delete all items in cart?',
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        bloc.add(DeleteAllCartEvent());
                                        Navigator.pop(context);
                                      },
                                      child: const Text('YES')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'))
                                ],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025),
                        child: ListView.builder(
                          itemCount: bloc.items.length,
                          itemBuilder: (context, index) {
                            ItemModel? item;
                            for (var element
                                in locator.get<DataLayer>().allItems) {
                              if (element.id ==
                                  locator
                                      .get<DataLayer>()
                                      .cart
                                      .items[index]
                                      .itemId) {
                                item = element;
                              }
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: CartItemCard(
                                size: size,
                                item: item!,
                                quantity: bloc.items[index].quantity,
                                bloc: bloc,
                                orderItem: bloc.items[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Total and Proceed to Checkout
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: const Color(0xff74a0b2),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${bloc.totalPrice} SAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                bottomSheet: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    color: const Color(0xff74a0b2),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${bloc.totalPrice} SAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (locator.get<DataLayer>().cart.items.isEmpty) {
                              return;
                            }
                            _showPaymentBottomSheet(context, size, bloc);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            minimumSize: Size(size.width * 0.4, 40),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              color: const Color(0xff74a0b2),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]));
          },
        );
      }),
    );
  }

  void _showPaymentBottomSheet(BuildContext context, Size size, CartBloc bloc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: CreditCard(
            config: bloc.pay(),
            onPaymentResult: (result) async {
              bloc.onPaymentResult(result, context);
              Navigator.pop(context, 'Payment successful');
            },
          ),
        );
      },
    ).then((value) async {
      if (value == 'Payment successful') {
        await Future.delayed(const Duration(seconds: 5));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderTracking()),
        );
      }
    });
  }

  Widget _buildTextField(String hint, IconData icon, Size size) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey[800],
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
