
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/screens/cart_screen/cart_item_card.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;

  PaymentConfig pay() {
    final paymentConfig = PaymentConfig(
      publishableApiKey: '${dotenv.env['moyasar_test_key']}',
      amount: (totalPrice * 100).toInt(),
      description: 'Onze Order',
      metadata: {'orderId': '1', 'customer': 'customer'},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );
    return paymentConfig;
  }

  void onPaymentResult(result, BuildContext context) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          saveOrder(totalPrice: totalPrice);
          locator.get<DataLayer>().cart.clearCart();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment successful!'),
          ));
          Navigator.pop(context, 'Payment successful');
          break;
        case PaymentStatus.failed:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment failed. Try again.'),
          ));
          break;
        case PaymentStatus.initiated:
        case PaymentStatus.authorized:
        case PaymentStatus.captured:
      }
    }
  }

  getTotalPrice() async {
    for (var item in locator.get<DataLayer>().cart.items) {
      totalPrice += item.price * item.quantity;
    }
  }

  @override
  void initState() {
    getTotalPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color(0xff74a0b2),
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
                              locator.get<DataLayer>().cart.clearCart();
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
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
              child: ListView.builder(
                itemCount: locator.get<DataLayer>().cart.items.length,
                itemBuilder: (context, index) {
                  ItemModel? item;
                  for (var element in locator.get<DataLayer>().allItems) {
                    if (element.id ==
                        locator.get<DataLayer>().cart.items[index].itemId) {
                      item = element;
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CartItemCard(
                        size: size,
                        item: item!,
                        quantity: locator
                            .get<DataLayer>()
                            .cart
                            .items[index]
                            .quantity),
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
                      '$totalPrice SAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: const Color(0xffbc793d),
                child: TextButton(
                  onPressed: () {
                    _showPaymentBottomSheet(context, size);
                  },
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPaymentBottomSheet(BuildContext context, Size size) {
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
            config: pay(),
            onPaymentResult: (result) => onPaymentResult(result, context),
          ),
        );
        // return Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'Payment Details',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: size.width * 0.06,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       const SizedBox(height: 20),
        //       _buildTextField('Cardholder Name', Icons.person, size),
        //       const SizedBox(height: 10),
        //       _buildTextField('Card Number', Icons.credit_card, size),
        //       const SizedBox(height: 10),
        //       Row(
        //         children: [
        //           Expanded(
        //               child: _buildTextField(
        //                   'Expiry Date', Icons.date_range, size)),
        //           const SizedBox(width: 10),
        //           Expanded(child: _buildTextField('CVC', Icons.lock, size)),
        //         ],
        //       ),
        //       const SizedBox(height: 20),
        //       Center(
        //         child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: const Color(0xffbc793d),
        //             padding: EdgeInsets.symmetric(
        //               horizontal: size.width * 0.3,
        //               vertical: 14,
        //             ),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(15),
        //             ),
        //           ),
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           child: Text(
        //             'Pay',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: size.width * 0.05,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
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
