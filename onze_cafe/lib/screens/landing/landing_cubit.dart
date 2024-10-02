import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../supabase/client/supabase_mgr.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingInitial()) {
    checkUserSession();
  }
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;

  void checkUserSession() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      await Future.delayed(Duration(milliseconds: 50));
      emit(UserSessionExists());
    }
  }
}