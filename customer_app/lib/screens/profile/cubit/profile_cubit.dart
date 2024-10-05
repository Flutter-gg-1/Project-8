import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/services/setup.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final ScrollController scrollController = ScrollController();
  final user = authLocator.get<AuthLayer>().user;
  getProfileData() async {
    try {
      // final res = await SuperMain()
    } catch (er) {
      log("$er");
    }
  }

void startAutoScroll() {
  Future.delayed(const Duration(milliseconds: 50), () {
    if (scrollController.hasClients) {

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 10),
        curve: Curves.easeIn,
      ).then((_) {

        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(seconds: 10),
          curve: Curves.easeIn,
        ).then((_) {

          startAutoScroll();
        });
      });
    }
  });
}

}
