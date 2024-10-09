import 'package:customer_app/screens/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class QuantityRow extends StatelessWidget {
  const QuantityRow({
    super.key,
    this.addMinusEvent,
    this.addAddEvent,
    required this.quantity,
  });
  final Function()? addMinusEvent;
  final Function()? addAddEvent;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: addMinusEvent,
            icon: const Icon(
              Iconsax.minus_square_bold,
              color: Color(0xffEFE3C8),
              size: 35,
            )),
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Text(
              ' $quantity ',
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rosarivo'),
            );
          },
        ),
        IconButton(
            onPressed: addAddEvent,
            icon: const Icon(
              Iconsax.add_square_bold,
              color: Color(0xffEFE3C8),
              size: 35,
            )),
      ],
    );
  }
}
