import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:understudy_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:understudy_app/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:understudy_app/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:user_repository/user_repository.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Expanded(
                  child: TabBarView(children: [
                BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
                  child: const SignInScreen(),
                ),
                BlocProvider<SignUpBloc>(
                  create: (context) => SignUpBloc(context.read<AuthenticationBloc>().userRepository),
                  child: const SignUpScreen(),
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
