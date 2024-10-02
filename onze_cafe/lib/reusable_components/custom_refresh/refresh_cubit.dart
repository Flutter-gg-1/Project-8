import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'refresh_state.dart';

class RefreshCubit extends Cubit<RefreshState> {
  RefreshCubit() : super(RefreshInitial());
  Future<void> refresh() async {
    try {
      emit(RefreshLoading()); 
      await Future.delayed(Duration(seconds: 1)); 
      emit(SuccessRefresh()); 
    } catch (e) {
      emit(ErrorRefresh()); 
    }
  }
}
