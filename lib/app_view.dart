import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:understudy_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:understudy_app/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:understudy_app/screens/auth/views/welcome_screen.dart';
import 'package:understudy_app/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Understudy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: HexColor("#F5E127"),
            colorScheme: ColorScheme.light(
                surface: HexColor("#1F1F1F"),
                onSurface: HexColor("#F5E127"),
                primary: HexColor("#F5E127"),
                onPrimary: HexColor("#1F1F1F"),
                secondary: HexColor("#FF6D3F"),
                tertiary: HexColor("#3B3B3B"),
                error: HexColor("#FB0606"),
                onSecondary: HexColor("#1F1F1F")),
            fontFamily: 'Courier Font',
            textTheme: TextTheme(
              displayMedium: GoogleFonts.courierPrime(
                fontSize: 20,
                fontStyle: FontStyle.normal,
              ),
              displayLarge: GoogleFonts.courierPrime(
                fontSize: 24,
                fontStyle: FontStyle.normal,
              ),
              displaySmall: GoogleFonts.courierPrime(
                fontSize: 18,
                fontStyle: FontStyle.normal,
              ),
              labelMedium: GoogleFonts.courierPrime(
                fontSize: 16,
                fontStyle: FontStyle.normal,
              ),
              labelSmall: GoogleFonts.courierPrime(
                fontSize: 10,
                fontStyle: FontStyle.normal,
              ),
              labelLarge: GoogleFonts.courierPrime(
                fontSize: 20,
                fontStyle: FontStyle.normal,
              ),
              bodyMedium: GoogleFonts.courierPrime(
                fontSize: 12,
                fontStyle: FontStyle.normal,
              ),
              bodySmall: GoogleFonts.courierPrime(
                fontSize: 10,
                fontStyle: FontStyle.normal,
              ),
              bodyLarge: GoogleFonts.courierPrime(
                fontSize: 14,
                fontStyle: FontStyle.normal,
              ),
              titleMedium: GoogleFonts.chicle(
                fontSize: 32,
                fontStyle: FontStyle.normal,
              ),
              titleLarge: GoogleFonts.chicle(
                fontSize: 40,
                fontStyle: FontStyle.normal,
              ),
              titleSmall: GoogleFonts.chicle(
                fontSize: 28,
                fontStyle: FontStyle.normal,
              ),
            ),
            focusColor: HexColor("#FBF6C7")),
        darkTheme: ThemeData.dark(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
                child: const HomeScreen(),
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        ));
  }
}
