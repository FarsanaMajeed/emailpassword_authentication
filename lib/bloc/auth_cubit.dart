

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginform_new/bloc/repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //Dependency injection
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());//default aayt first authinitial emit aavan

  registerUserEmailPassword(String email, String password) async {
    emit(AuthLoading());
    try{
    UserCredential userCredential= await authRepository.registerWithEmailPassword(email, password);
    if(userCredential==null){
      emit(AuthError());
    }else{
      //registration success email and password (all data)can access using userCredential
      emit(AuthSuccess(userCredential));
    }
    }catch(ex) {
      emit(AuthError());
    }
    }


  signInUserEmailPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await authRepository.loginWithEmailPassword(email, password);
     if(userCredential==null){
       emit(AuthError());
     }else{
       //userCredential constructor pass the user data through the authSuccess  class
       //and the passed data stored the userCredential variable inside the states
       // when the  login success the user details is can access by using userCredential
       emit(AuthSuccess(userCredential));
     }
    }
    catch(ex){
      emit(AuthError());
    }
  }
}


