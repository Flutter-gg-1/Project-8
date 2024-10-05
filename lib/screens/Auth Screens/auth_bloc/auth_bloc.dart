import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/services/db_operations.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(addNewAccount);
    on<ResendOtpEvent>(resenOtp);
    on<VerifyEvent>(verifyAccount);
    on<LoginEvent>(loginUser);
  }

  FutureOr<void> addNewAccount(
      RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await createAccount(email: event.email, password: event.password);
      emit(SuccessfulRegisterState());
    } catch (error) {
      emit(ErrorState(message: "Failed to Register, try again"));
    }
  }

   FutureOr<void> resenOtp(ResendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await resendOtp(email: event.email);

      emit(SuccessfulResentOTPState());
    } catch (error) {
      emit(ErrorState(message: "Failed to Register, try again"));
    }
  }

  FutureOr<void> verifyAccount(
      VerifyEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await verify(
          email: event.email,
          otp: event.otp,
          name: event.name,
          phone: event.phone);
      await login(email: event.email, password: event.password);
      emit(SuccessfulVerifyState());
    } catch (error) {
      emit(ErrorState(message: "Failed to Verify, try again"));
    }
  }

  FutureOr<void> loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await login(email: event.email, password: event.password);
      emit(SuccessfulLoginState());
    } catch (error) {
      emit(ErrorState(message: "Failed to Login, try again"));
    }
  }
}
