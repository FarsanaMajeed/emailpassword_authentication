import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginform_new/bloc/repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  registerUserEmailPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await authRepository.registerWithEmailPassword(email, password);
      if (userCredential == null) {
        emit(AuthError());
      } else {
        emit(AuthSuccess(userCredential));
      }
    } catch (ex) {
      emit(AuthError());
    }
  }

  signInUserEmailPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await authRepository.loginWithEmailPassword(email, password);
      if (userCredential == null) {
        emit(AuthError());
      } else {
        emit(AuthSuccess(userCredential));
      }
    } catch (ex) {
      emit(AuthError());
    }
  }
}
