

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginform_new/bloc/auth_cubit.dart';
import 'package:loginform_new/src/pages/dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    TextFormField(
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
                    Divider(thickness: 4),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        String data = val ?? '';
                        if (data.trim().isEmpty) {
                          return ' Please enter password';
                        } else if (data.length > 6) {
                          return "password must be 6 length";
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
                    //here gives used cubit and state name
                    //BlockConsumer used instead of BlockBuilder and BlockBuilder
                    BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if(state is AuthSuccess){
                            Navigator.push(context, MaterialPageRoute(builder:(_)=> DashboardPage()));
                          }else if(state is AuthError){
                            Fluttertoast.showToast(msg: "Login failed");
                          }else{

                          }
                        },
                        builder: (context, state) {
                          //the value 0f the state variable equal to the state emit from the cubit
                          //ElevatedButton wrap with BlockBuilder for when login click the ElevatedButton changed for an loader
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return ElevatedButton(
                              onPressed: () {
                                String email = emailController.text.trim();
                                String password = passwordController.text.trim();
                                BlocProvider.of<AuthCubit>(context)
                                    .signInUserEmailPassword(email, password);
                              },
                              child: const Text('login'),
                            );
                          }
                        }),
                  ],
                )),
          ),
        ),
      ]),

    );
  }
}
