import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/screens/profile/cubit/profile_cubit.dart';
import 'package:employee_app/widget/profile/profile_img.dart';
import 'package:employee_app/widget/profile/profile_info.dart';
import 'package:employee_app/widget/profile/profile_most_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ProfileCubit>();
        cubit.startAutoScroll();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              context.addSpacer(multiply: 0.01),
              const ProfileImg(),
              Text(
                "${cubit.user?.firstName} ${cubit.user?.lastName}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 100,
              ),
              const ProfileInfo(
                icons: Icons.phone_outlined,
                labelTex: "Mobile Phone",
                labelVal: "0549898989",
              ),
              context.addSpacer(multiply: 0.02),
              ProfileInfo(
                icons: Icons.mail_outline,
                labelTex: "Email Address",
                labelVal: '${cubit.user?.email}',
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, bottom: 20),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Most Ordered",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SingleChildScrollView(
                controller: cubit.scrollController,
                scrollDirection: Axis.horizontal,
                child: const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    ProfileMostOrderWidget(),
                    SizedBox(
                      width: 20,
                    ),
                    ProfileMostOrderWidget(),
                    SizedBox(
                      width: 20,
                    ),
                    ProfileMostOrderWidget(),
                    SizedBox(
                      width: 20,
                    ),
                    ProfileMostOrderWidget(),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
