import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginform_new/bloc/auth_cubit.dart';
import 'package:loginform_new/src/pages/dashboard_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration Form',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                        labelText: " Full Name",
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Enter phone number",

                      hintText: '0000000000',
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    maxLength: 10,
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp("^[a-zA-ZO-9+_.-]+@[a-zA-ZO-9.-]+.[a-z]")
                        .hasMatch(val)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(

                      labelText: "Enter email",
                      hintText: "email@gmail.com",
                      prefixIcon:Icon(Icons.mail),
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  maxLength: 25,
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (val) {
                    String data = val ?? '';
                    if (data.isEmpty) {
                      return 'Please enter password';
                    } else if (data.length < 8) {
                      return 'Password length should not be less than 8 character';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    labelText: "Enter password",
                    prefixIcon: Icon(Icons.security),
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    validator: (val) {
                      String data = val ?? '';
                      if (data.isEmpty) {
                        return 'please enter password';
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        return "password doesn't match";
                      } else {
                        return null;
                      }
                    },
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: "confirm password",
                      prefixIcon: Icon(Icons.security),
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    widthFactor: 50,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DashboardPage()));
                        } else if (state is AuthError) {
                          Fluttertoast.showToast(msg: 'Registration failed');
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return CircularProgressIndicator();
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              BlocProvider.of<AuthCubit>(context)
                                  .registerUserEmailPassword(email, password);
                            },
                            child: Text("Register"),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
