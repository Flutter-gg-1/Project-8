import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/admin_screens/admin_dashboard_screen.dart';
import 'package:onze_cafe/supabase/supabase_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../supabase/client/supabase_mgr.dart';
import '../auth/auth_screen.dart';
import '../menu/menu_screen.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingInitial()) {
    checkUserSession();
  }
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;

  void checkUserSession() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      SupabaseMgr.shared.currentUser = supabase.auth.currentUser;
      final profile = await SupabaseProfile.fetchProfile(
          SupabaseMgr.shared.currentUser?.id ?? '');

      // Check profile role and emit corresponding state
      if (profile?.role == 'employee') {
        emit(EmployeeUserState());
      } else {
        emit(RegularUserState());
      }
    }
  }

  void navigateToAuth(BuildContext context, bool isSignup) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(isSignup: isSignup)));

  void navigateToMenu(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => MenuScreen()));

  void navigateToDashboard(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminDashboardScreen()));
}
