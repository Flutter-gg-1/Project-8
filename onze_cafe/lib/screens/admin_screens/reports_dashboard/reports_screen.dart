import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/enums/days_filter.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/reports_cubit.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/subviews/donut_chart_view.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/subviews/filter_menu_item.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/subviews/line_chart_view.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/subviews/reports_dashboard_view.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
        create: (context) => ReportsCubit(),
        child: Builder(builder: (context) {
          final cubit = context.read<ReportsCubit>();
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
                actions: [
                  BlocBuilder<ReportsCubit, ReportsState>(
                    builder: (context, state) {
                      DaysFilter? selectedFilter;

                      if (state is ReportsFilterSelected) {
                        selectedFilter = state.selected;
                      } else {
                        selectedFilter = DaysFilter.today;
                      }

                      return FilterMenuView(
                          selectedFilter: selectedFilter, cubit: cubit);
                    },
                  ),
                ],
              ),
              body: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: ListView(children: [
                        ReportsDashBoardView(brightness: brightness),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text("Best Selling Items").styled(
                              color: C.primary(brightness),
                              weight: FontWeight.w700,
                              size: 16),
                        ),
                        DonutChartview(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text("Highest Selling Times").styled(
                              color: C.primary(brightness),
                              weight: FontWeight.w700,
                              size: 16),
                        ),
                        //need to display all hours
                        LineChartView()
                      ]))));
        }));
  }
}
