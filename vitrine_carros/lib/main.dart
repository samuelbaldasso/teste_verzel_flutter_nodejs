import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vitrine_carros/pages/auth/login/login.dart';
import 'package:vitrine_carros/pages/auth/register/register.dart';
import 'package:vitrine_carros/pages/home/home.dart';

import 'package:vitrine_carros/repositories/api_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ApiRepositoryImpl>(
      create: (context) => ApiRepositoryImpl(),
      child: MaterialApp(
          title: 'Vitrine de Carros',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: false,
              fontFamily: GoogleFonts.robotoSlab().fontFamily,
              textTheme: const TextTheme(
                  bodyMedium: TextStyle(color: Colors.deepPurple))),
          routes: {
            "/": (context) => const Login(),
            "/register": (context) => const Register(),
            "/home": (context) => const HomePage(),
          }),
    );
  }
}
