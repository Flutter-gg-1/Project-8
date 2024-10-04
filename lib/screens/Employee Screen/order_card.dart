import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/Employee%20Screen/employee_bloc/employee_bloc.dart';
import 'package:onze_cafe/services/setup.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final EmployeeBloc bloc;
  final int index;
  const OrderCard({super.key, required this.order, required this.bloc, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Container(
            height: 124,
            width: 340,
            padding: const EdgeInsets.only(right: 12, top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Image.network(
                      locator.get<DataLayer>().orders[index]['item']
                          ['image_url'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            locator.get<DataLayer>().orders[index]['item']
                                ['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                            '${locator.get<DataLayer>().orders[index]['quantity']}'),
                        const SizedBox(height: 5),
                        Text(
                          'Price: SAR ${locator.get<DataLayer>().orders[index]['price']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3D6B7D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        bloc.add(ReadyEvent(order: order));
                      },
                      child: const Text(
                        'Ready',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffA8483D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text(
                                    'Do you want to Cancel this order?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        bloc.add(CancelEvent(order: order));
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
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
