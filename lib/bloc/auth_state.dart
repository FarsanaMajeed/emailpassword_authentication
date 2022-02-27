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
  //for access the user details from userCredential variable from the authentication success
  final UserCredential userCredential;
  //here declare the userCredential for storing the user data initialize through the constructor
  AuthSuccess(this.userCredential);

  @override
  //here the userCredential inside props for display the  user data in the ui
  List<Object> get props => [userCredential];
}
class AuthError extends AuthState {
  @override
  List<Object> get props => [];
}
