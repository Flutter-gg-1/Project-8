import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/model/profile.dart';
import 'package:onze_cafe/screens/order/orders_screen.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';

import '../profile/profile_screen.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());
  Profile? profile;
  bool isEnglish = false;
  bool isDarkMode = false;

  void fetchProfile() {
    profile = SupabaseMgr.shared.currentProfile;
    emit(UpdateUIState());
  }

  void toggleIsEnglish() {
    isEnglish = !isEnglish;
    emit(UpdateUIState());
  }

  void toggleIsDarkMode() {
    isDarkMode = !isDarkMode;
    emit(UpdateUIState());
  }

  void navigateToProfile(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const ProfileScreen()));

  void navigateToOrders(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const OrdersScreen()));
}
