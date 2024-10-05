import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/enums/cup_size.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

class SizeSelectionView extends StatelessWidget {
  const SizeSelectionView({super.key, required this.cubit});
  final ItemDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Text("Size").styled(
              color: C.bg1(brightness), weight: FontWeight.w600, size: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: CupSize.values
                .map((s) => _SizeCardView(cubit: cubit, cupSize: s))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SizeCardView extends StatelessWidget {
  const _SizeCardView({required this.cubit, required this.cupSize});
  final ItemDetailsCubit cubit;
  final CupSize cupSize;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: (cupSize == CupSize.small)
                    ? context.screenWidth * 0.13
                    : (cupSize == CupSize.medium)
                        ? context.screenWidth * 0.15
                        : context.screenWidth * 0.17),
            child: AspectRatio(
              aspectRatio: 1,
              child: InkWell(
                onTap: () => cubit.selectSize(cupSize),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(3, 3),
                        blurRadius: 6,
                      )
                    ],
                    color: cubit.selectedSize == cupSize
                        ? C.accent(brightness)
                        : C.bg3(brightness),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      'assets/SVG/outlined_cup.svg',
                      colorFilter: ColorFilter.mode(
                          cubit.selectedSize == cupSize
                              ? C.secondary(brightness)
                              : C.accent(brightness),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            cupSize.strValue(),
          ).styled(
            size: 18,
            weight: FontWeight.w400,
            color: cubit.selectedSize == cupSize
                ? C.accent(brightness)
                : C.bg1(brightness),
          ),
        ),
      ],
    );
  }
}
