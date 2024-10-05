import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../reusable_components/animated_snackbar.dart';
import '../../../supabase/supabase_auth.dart';
import '../../landing/landing_screen.dart';

part 'employee_dashboard_state.dart';

class EmployeeDashboardCubit extends Cubit<EmployeeDashboardState> {
  EmployeeDashboardCubit() : super(EmployeeDashboardInitial());

  Future signOut(BuildContext context) async {
    try {
      emitLoading();
      await SupabaseAuth.signOut();

      if (context.mounted) {
        showSnackBar(context, 'Signed out', AnimatedSnackBarType.success);
      }

      await Future.delayed(Duration(milliseconds: 50));

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      }
      emitUpdate();
    } catch (e) {
      emitUpdate();
      if (context.mounted) {
        showSnackBar(context, 'Failed to Sign-out', AnimatedSnackBarType.error);
      }
    }
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
