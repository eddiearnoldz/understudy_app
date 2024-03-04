import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:understudy_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:understudy_app/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:understudy_app/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:understudy_app/screens/auth/views/sign_in_screen.dart';
import 'package:understudy_app/screens/auth/views/sign_up_screen.dart';
import 'package:user_repository/user_repository.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  TabBar(controller: tabController, labelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), tabs: const [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Sign In'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Sign Up'),
                    )
                  ]),
                  Expanded(
                      child: TabBarView(controller: tabController, children: [
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
        ),
      ),
    );
  }
}
