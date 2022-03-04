part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  final UserCredential userCredential;

  AuthSuccess(this.userCredential);
  @override
  List<Object> get props => [userCredential];
}

class AuthError extends AuthState {
  @override
  List<Object> get props => [];
}
