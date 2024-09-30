import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onze_coffee_app/cubit/user_home/user_home_cubit.dart';
import 'package:onze_coffee_app/data/repositories/order_repository.dart';
import 'package:onze_coffee_app/data/repositories/payment_repository.dart';
import 'package:onze_coffee_app/screen/employee/emp_add_product_screen.dart';
import 'package:onze_coffee_app/widget/comment/custom_choice_chip.dart';
import 'package:onze_coffee_app/widget/comment/product_view.dart';

class EmpProductsScreen extends StatelessWidget {
  const EmpProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeCubit(),
      child: Builder(
        builder: (context) {
          final homeCubit = context.read<UserHomeCubit>();
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomChoiceChip(
                        selected: true,
                        text: "All Coffee",
                        onSelected: (bool value) {},
                      ),
                      CustomChoiceChip(
                        selected: false,
                        text: "Black",
                        onSelected: (bool value) {},
                      ),
                      CustomChoiceChip(
                        selected: false,
                        text: "Spanish",
                        onSelected: (bool value) {},
                      ),
                      CustomChoiceChip(
                        selected: false,
                        text: "Choclete",
                        onSelected: (bool value) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<UserHomeCubit, UserHomeState>(
                  builder: (context, state) {
                    return GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: .75),
                        children: List.generate(homeCubit.products.length,
                            (int index) {
                          return ProductView(
                            imageSrc:
                                homeCubit.products[index].imageUrls.first ?? "",
                            onPressed: () {},
                            name: homeCubit.products[index].productName,
                            price:
                                "${homeCubit.products[index].variants.first.price}",
                            type: homeCubit.products[index].productCategory,
                          );
                        }));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
