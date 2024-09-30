import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_coffee_app/cubits/category_cubit/category_cubit.dart';
import 'package:onze_coffee_app/cubits/user_home/user_home_cubit.dart';
import 'package:onze_coffee_app/helper/custom_colors.dart';
import 'package:onze_coffee_app/helper/screen.dart';
import 'package:onze_coffee_app/screen/shared/product_details_screen.dart';
import 'package:onze_coffee_app/widget/comment/product_view.dart';
import 'package:onze_coffee_app/widget/custom_choice_chip.dart';
import 'package:onze_coffee_app/widget/image_banner.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeCubit(),
      child: Builder(builder: (context) {
        final homeCubit = context.read<UserHomeCubit>();
        return SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: context.getWidth(value: 1),
                  height: context.getWidth(value: 1),
                  decoration: const BoxDecoration(color: AppColor.primary),
                  child: Image.asset("assets/logo/onze_logo.png"),
                ),
                const ImageBanner(imageSrc: "assets/banner/Banner.png"),
                const SizedBox(
                  height: 10,
                ),
                BlocProvider(
                  create: (context) => CategoryCubit(),
                  child: Builder(builder: (context) {
                    final categoryReadCubit = context.read<CategoryCubit>();
                    return BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                categoryReadCubit.categoryLayer.userCategories
                                    .length, (int index) {
                              return Row(
                                children: [
                                  CustomChoiceChip(
                                    lblColor: AppColor.white,
                                    selectedColor: AppColor.secondary,
                                    isSelected:
                                        categoryReadCubit.userProductCategory ==
                                            categoryReadCubit.categoryLayer
                                                .userCategories[index]["id"],
                                    title: categoryReadCubit.categoryLayer
                                        .userCategories[index]["name"],
                                    onSelected: (p0) {
                                      categoryReadCubit.userProductCategory =
                                          categoryReadCubit.categoryLayer
                                              .userCategories[index]["id"];
                                      categoryReadCubit.updateChips();
                                      homeCubit.filterProduct(categoryReadCubit
                                          .categoryLayer
                                          .userCategories[index]["name"]);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              );
                            }),
                          ),
                        );
                      },
                    );
                  }),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                          product: homeCubit.products[index],
                                        )),
                              );
                            },
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
          ),
        );
      }),
    );
  }
}
