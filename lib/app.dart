import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginform_new/bloc/auth_cubit.dart';
import 'package:loginform_new/bloc/repository.dart';
import 'package:loginform_new/src/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthRepository repository=AuthRepository();
    //create object of AuthRepository class
    return MultiBlocProvider(providers: [
      BlocProvider(create:(context)=>AuthCubit(AuthRepository()))],
      //for access multiple cubit on evey page of material app used MultiBlockProvider
      child:MaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(),
      )
    );
  }
}
