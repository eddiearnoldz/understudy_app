import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:understudy_app/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signUpRequired = false;
  bool obscurePassword = true;
  bool containsNumberOrChar = false;
  bool containsLowerCase = false;
  bool containsUpperCase = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          signUpRequired = true;
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in the email field';
                    } else if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: const InputDecoration(hintText: 'email'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in the password field';
                    } else if (!RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d|\W).{8,}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                      hintText: 'password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                              if (obscurePassword) {
                                iconPassword = CupertinoIcons.eye_fill;
                              } else {
                                iconPassword = CupertinoIcons.eye_fill;
                              }
                            });
                          },
                          icon: Icon(iconPassword))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in the name field';
                    }
                    return null;
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: const InputDecoration(hintText: 'name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in the location field';
                    }
                    return null;
                  },
                  controller: locationController,
                  keyboardType: TextInputType.none,
                  obscureText: false,
                  decoration: const InputDecoration(hintText: 'city'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              !signUpRequired
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              MyUser myUser = MyUser.empty;
                              myUser.email = emailController.text;
                              myUser.name = nameController.text;
                              myUser.location = locationController.text;
                              setState(() {
                                context.read<SignUpBloc>().add(SignUpRequired(myUser, passwordController.text));
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.amber, fontSize: 12),
                            ),
                          )),
                    )
                  : const CircularProgressIndicator()
            ],
          )),
    );
  }
}
