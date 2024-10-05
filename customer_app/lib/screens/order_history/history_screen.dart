import 'package:customer_app/helper/date_format.dart';
import 'package:customer_app/helper/extinsion/loading_dialog.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/order_history/cubit/order_history_cubit.dart';
import 'package:customer_app/widget/cart_widget/custome_text_tow_direction.dart';
import 'package:customer_app/widget/cart_widget/seprate_divider.dart';
import 'package:customer_app/widget/coulmn/history_order_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => OrderShowCubit(),
          child: Builder(builder: (context) {
            final cubit = context.read<OrderShowCubit>();
            cubit.getAllUserOrder(status: "delivered");
            return SingleChildScrollView(
              child: BlocConsumer<OrderShowCubit, OrderShowState>(
                listener: (context, state) {
                  if (state is LoadingState) {
                    context.showLoadingDialog();
                  }
                  if (state is ErrorState) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.msg,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.red,
                    ));
                  }
                  if (state is SussesState) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return cubit.orderList.isNotEmpty
                      ? Column(
                          children: List.generate(
                            cubit.orderList.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        context.getHeight(multiply: 0.04)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: context.getHeight(multiply: 0.05),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        formatTimestamp(
                                            timestamp:
                                                cubit.orderList[index].time!),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      width: context.getWidth(multiply: 0.84),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black26),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: context.getHeight(
                                                multiply: 0.017),
                                            vertical: context.getWidth(
                                                multiply: 0.04)),
                                        child: HistoryOrderColumn(
                                          cubit: cubit,
                                          index: index,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              context.addSpacer(multiply: 0.3),
                              const Text(
                                "'You don't have any previous orders :(",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Rosarivo',
                                    color: Color(0xffA8483D)),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Order Now",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xff87B1C5),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Rosarivo',
                                      color: Color(0xff87B1C5)),
                                ),
                              )
                            ],
                          ),
                        );
                },
              ),
            );
          }),
        ));
  }
}
