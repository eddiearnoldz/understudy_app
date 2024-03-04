import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:understudy_app/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "TEST - YOU'RE IN",
          ),
          TextButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sign Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 12),
                ),
              )),
        ],
      )),
    );
  }
}
