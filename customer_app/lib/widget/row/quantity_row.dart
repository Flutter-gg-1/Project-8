import 'package:customer_app/screens/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class QuantityRow extends StatelessWidget {
  const QuantityRow({
    super.key,
    required this.bloc,
  });

  final OrderBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              bloc.add(MinusEvent());
            },
            icon: const Icon(
              Iconsax.minus_square_bold,
              color: Color(0xffEFE3C8),
              size: 35,
            )),
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Text(
              ' ${bloc.quantity} ',
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rosarivo'),
            );
          },
        ),
        IconButton(
            onPressed: () {
              bloc.add(AddEvent());
            },
            icon: const Icon(
              Iconsax.add_square_bold,
              color: Color(0xffEFE3C8),
              size: 35,
            )),
      ],
    );
  }
}
