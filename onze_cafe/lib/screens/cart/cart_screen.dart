import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/screens/cart/cart_cubit.dart';
import 'package:onze_cafe/screens/payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void navigateToPayment(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const PaymentScreen()));

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => CartCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          body: SafeArea(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartInitial ) {
                  return const Center(child: Text('Your cart is empty.'));
                } else if (state is CartUpdatedState) {
                  final cartItems = state.cartItems;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return ListTile(
                              title: Text(item.name),
                              subtitle: Text(
                                  'Count: ${item.count} - Total Price: ${item.price} RS'),
                              leading: Image.asset(item
                                  .image), // Assuming item.image is a valid asset path
                              trailing: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  context.read<CartCubit>().removeItem(item);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () => navigateToPayment(context),
                        child: const Text('Proceed to Payment'),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      }),
    );
  }
}
