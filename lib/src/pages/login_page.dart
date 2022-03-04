// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginform_new/bloc/auth_cubit.dart';
import 'package:loginform_new/src/pages/dashboard_page.dart';
import 'package:loginform_new/src/pages/reg_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
      children: [
       SizedBox(height: 12),
        Padding(
          padding:EdgeInsets.only(top: 100,left: 10,right: 10),
          child: TextFormField(
          validator: (val) {
            String data = val ?? '';
            if (data.trim().isEmpty) {
              return ' Please enter email';
            }
          },
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "Enter email",
              contentPadding: EdgeInsets.all(4),
              border: OutlineInputBorder()),
        ),
        ),
        Padding(
          padding:EdgeInsets.only(top: 20,left: 10,right: 10),
          child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (val) {
            String data = val ?? '';
            if (data.trim().isEmpty) {
              return ' Please enter password';
            } else if (data.length < 8) {
              return "password must be 8 length";
            }
          },
          controller: passwordController,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: "password",
            suffix: obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = false;
                      });
                    },
                    icon: Icon(Icons.visibility))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = true;
                      });
                    },
                    icon: Icon(Icons.visibility_off)),
            contentPadding: EdgeInsets.all(4),
            border: OutlineInputBorder(),
          ),
        ),
        ),
        BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => DashboardPage()));
          } else if (state is AuthError) {
            Fluttertoast.showToast(msg: "Login failed");
          } else {}
        }, builder: (context, state) {
          if (state is AuthLoading) {
            return const CircularProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.only(top:10),
              child: ElevatedButton(
                onPressed: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  BlocProvider.of<AuthCubit>(context)
                      .signInUserEmailPassword(email, password);
                },
                child: const Text('login'),
              ),
            );
          }
        }),
       InkWell(
         onTap: (){
           Navigator.push(context,MaterialPageRoute(builder:(_)=> RegistrationPage()));
         },
           child: Padding(
          padding:EdgeInsets.all(10),
          child:Center(
            child: Row(
              children: [
                Padding(

                  padding: const EdgeInsets.only(left:90),
                  child: Text('create an account ?',style: TextStyle(color: Colors.blue,fontSize: 18),),
                ),
              ],
            ),
          )
        )
       ),
      ],
    ));
  }
}
