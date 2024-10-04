import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/date_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/offer.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_offer/add_offer_cubit.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_offer/network_functions.dart';
import 'package:onze_cafe/utils/validations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
        return Scaffold(
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
                      Card(
                        elevation: 2,
                        shadowColor: C.secondary(brightness).withOpacity(0.7),
                        color: C.bg1(brightness),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(child: Text('Menu Item')),
                              BlocBuilder<AddOfferCubit, AddOfferState>(
                                builder: (context, state) {
                                  return cubit.selectedMenuItem == null
                                      ? Text('You must add at least 1 category!')
                                          .styled(
                                              color: C.secondary(brightness),
                                              weight: FontWeight.bold,
                                              size: 18)
                                      : DropdownButton<String>(
                                          value: cubit.selectedMenuItem?.name ??
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
                                              final selectedCategory = menuItems
                                                  .where((category) =>
                                                      category.name == newValue)
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
                                      _DateBtnView(
                                        cubit: cubit,
                                        isStartDate: true,
                                      ),
                                      SizedBox(width: 16),
                                      _TimeBtnView(
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
                                      _DateBtnView(
                                        cubit: cubit,
                                        isStartDate: false,
                                      ),
                                      SizedBox(width: 16),
                                      _TimeBtnView(
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
        );
      }),
    );
  }
}

class _DateBtnView extends StatelessWidget {
  const _DateBtnView({required this.cubit, required this.isStartDate});
  final bool isStartDate;
  final AddOfferCubit cubit;

  @override
  Widget build(BuildContext context) {
    var date = isStartDate ? cubit.startDate : cubit.endDate;
    return ElevatedButton.icon(
      icon: Icon(Icons.calendar_today),
      label: Text(date.toFormattedString()),
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          DateTime finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            date.hour,
            date.minute,
          );
          isStartDate
              ? cubit.updateStartDate(finalDateTime)
              : cubit.updateEndDate(finalDateTime);
        }
      },
    );
  }
}

class _TimeBtnView extends StatelessWidget {
  const _TimeBtnView({required this.isStartDate, required this.cubit});
  final bool isStartDate;
  final AddOfferCubit cubit;

  @override
  Widget build(BuildContext context) {
    var date = isStartDate ? cubit.startDate : cubit.endDate;
    return ElevatedButton.icon(
      icon: Icon(Icons.access_time),
      label: Text(TimeOfDay.fromDateTime(date).format(context)),
      onPressed: () async {
        // Show time picker
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        // If a time was picked, update the Cubit state
        if (pickedTime != null) {
          // Combine the selected time with the existing date
          DateTime finalDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          isStartDate
              ? cubit.updateStartDate(finalDateTime)
              : cubit.updateEndDate(finalDateTime);
        }
      },
    );
  }
}
