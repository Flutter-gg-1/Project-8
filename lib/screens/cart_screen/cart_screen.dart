import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_xWUPFwQABVUruCau7j64Cvm7tyrqFBHkeB4he8RY',
    amount: 100, // SAR 1
    description: 'Order #1324',
    metadata: {'orderId': '1324', 'customer': 'John Doe'},
    creditCard: CreditCardConfig(saveCard: true, manual: false),
    applePay: ApplePayConfig(merchantId: '????', label: 'Cafe', manual: false),
  );

  void onPaymentResult(result, BuildContext context) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          saveOrder(totalPrice: totalPrice);
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

  double totalPrice = 0;

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
            const Color(0xff74a0b2), // Use the same color as HomeScreen
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
          color: Colors.white, // Icon color white to match the theme
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline, // Trash icon to remove all items from cart
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
            config: paymentConfig,
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

class CartItemCard extends StatelessWidget {
  final Size size;
  final ItemModel item;
  final int quantity;
  const CartItemCard(
      {super.key,
      required this.size,
      required this.item,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xfff0e5d8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.imageUrl,
              width: size.width * 0.25,
              height: size.width * 0.25,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'SAR ${item.price}',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffbc793d),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove, color: Colors.black),
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
