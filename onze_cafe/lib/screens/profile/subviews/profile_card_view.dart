import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../../../extensions/color_ext.dart';
import '../profile_cubit.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView({super.key, required this.cubit});
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        elevation: 2,
        shadowColor: C.secondary(brightness).withOpacity(0.7),
        color: C.bg1(brightness),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: C.primary(brightness), width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipOval(
                            child: cubit.profile?.avatarUrl != null
                                ? Image.network(cubit.profile!.avatarUrl!,
                                    fit: BoxFit.cover)
                                : const Icon(CupertinoIcons.person_fill,
                                    size: 40)),
                      )),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text('Hello ${cubit.profile?.name ?? ''}').styled(
                    color: C.primary(brightness),
                    size: 18,
                    weight: FontWeight.bold),
                subtitle: Text(cubit.profile?.email ?? 'anonymous')
                    .styled(color: C.primary(brightness)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
