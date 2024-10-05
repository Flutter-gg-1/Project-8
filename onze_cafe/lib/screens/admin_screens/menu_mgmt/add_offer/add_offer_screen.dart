import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/offer.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_offer/add_offer_cubit.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_offer/network_functions.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_offer/subviews/date_btn_view.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_offer/subviews/time_btn_view.dart';
import 'package:onze_cafe/utils/validations.dart';

import '../../../../extensions/color_ext.dart';
import '../../../../model/menu_item.dart';
import '../../../../reusable_components/buttons/circle_btn.dart';

class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({super.key, this.offer, required this.menuItems});

  final Offer? offer;
  final List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOfferCubit(offer, menuItems),
      child: Builder(builder: (context) {
        final cubit = context.read<AddOfferCubit>();
        final brightness = Theme.of(context).brightness;
        return BlocListener<AddOfferCubit, AddOfferState>(
          listener: (context, state) {
            if (state is LoadingState) {}
            if (state is UpdateUIState) {}
          },
          child: Scaffold(
            backgroundColor: C.bg1(brightness),
            appBar: AppBar(
              backgroundColor: C.bg1(brightness),
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(CupertinoIcons.chevron_left_square_fill),
                iconSize: 40,
                color: C.primary(brightness),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListView(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                              width: 120,
                              height: 120,
                              child: BlocBuilder<AddOfferCubit, AddOfferState>(
                                builder: (context, state) {
                                  return Image.network(
                                      cubit.selectedMenuItem!.imgUrl!);
                                },
                              )),
                        ),
                        Card(
                          elevation: 2,
                          shadowColor: C.secondary(brightness).withOpacity(0.7),
                          color: C.bg1(brightness),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Expanded(child: Text('Menu Item').styled()),
                                BlocBuilder<AddOfferCubit, AddOfferState>(
                                  builder: (context, state) {
                                    return cubit.selectedMenuItem == null
                                        ? Text('You must add at least 1 category!')
                                            .styled(
                                                color: C.secondary(brightness),
                                                weight: FontWeight.bold,
                                                size: 18)
                                        : DropdownButton<String>(
                                            value:
                                                cubit.selectedMenuItem?.name ??
                                                    '',
                                            items: List.generate(
                                              menuItems.length,
                                              (index) {
                                                String value =
                                                    menuItems[index].name;
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              },
                                            ),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                final selectedCategory =
                                                    menuItems
                                                        .where((category) =>
                                                            category.name ==
                                                            newValue)
                                                        .firstOrNull;

                                                // Update the cubit with the selected category
                                                if (selectedCategory != null) {
                                                  cubit.updatedSelectedItem(
                                                      selectedCategory);
                                                }
                                              }
                                            },
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomTextField(
                            hintText: 'Price',
                            controller: cubit.priceController,
                            validation: Validations.validateDouble),
                        BlocBuilder<AddOfferCubit, AddOfferState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                // Start Date
                                Row(
                                  children: [
                                    Expanded(child: Text('Start Date:')),
                                    Row(
                                      children: [
                                        // Date Button
                                        DateBtnView(
                                            cubit: cubit, isStartDate: true),
                                        SizedBox(width: 16),
                                        TimeBtnView(
                                            isStartDate: true, cubit: cubit)
                                      ],
                                    ),
                                  ],
                                ),
                                // End Date
                                Row(
                                  children: [
                                    Expanded(child: Text('End Date:')),
                                    Row(
                                      children: [
                                        // Date Button
                                        DateBtnView(
                                            cubit: cubit, isStartDate: false),
                                        SizedBox(width: 16),
                                        TimeBtnView(
                                            isStartDate: false, cubit: cubit)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<AddOfferCubit, AddOfferState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => cubit.upsertOffer(context),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomPaint(
                                    size: Size(0,
                                        90), // Specify the size for your custom painting
                                    painter: CircleBtn()),
                              ),
                            ],
                          ),
                          Text(offer == null ? 'Create Offer' : 'Update Offer')
                              .styled(
                                  size: 16,
                                  color: C.bg1(brightness),
                                  weight: FontWeight.bold)
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
