import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

class DonutChartview extends StatelessWidget {
  const DonutChartview({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //remove sized box
        SizedBox(
          height: 250,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: 260,
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  sections: [
                    PieChartSectionData(
                      value: 45,
                      gradient: G.primary,
                      radius: 45,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 35,
                      gradient: G.secondary,
                      radius: 45,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 20,
                      gradient: G.accent,
                      radius: 45,
                      showTitle: false,
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(48),
                        decoration: BoxDecoration(
                          color: C.bg3(brightness),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Text("1000")
                            .styled(size: 18, weight: FontWeight.w500))
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BestSelling(
                brightness: brightness,
                color: C.primary(brightness),
                item: 'Americano',
              ),
              BestSelling(
                brightness: brightness,
                color: C.secondary(brightness),
                item: 'Americano',
              ),
              BestSelling(
                brightness: brightness,
                color: C.accent(brightness),
                item: 'Americano',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BestSelling extends StatelessWidget {
  const BestSelling(
      {super.key,
      required this.brightness,
      required this.color,
      required this.item});

  final Brightness brightness;
  final Color color;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset.zero,
                color: color.withOpacity(0.7),
                blurRadius: 5,
              )
            ],
            color: C.bg3(brightness),
          ),
          child: Icon(
            Icons.coffee,
            color: color,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(item).styled(weight: FontWeight.w500, size: 16)
      ],
    );
  }
}
