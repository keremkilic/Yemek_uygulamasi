import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/detaysayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:bitirme_projesi/ui/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnaSayfaCubit(),),
        BlocProvider(create: (context) => DetaySayfaCubit(),),
        BlocProvider(create: (context) => SepetSayfaCubit(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          splash: Image.asset("assets/images/splash_image.png"),
          nextScreen: const AnaSayfa(),
          splashTransition: SplashTransition.scaleTransition,
          animationDuration: const Duration(milliseconds: 1500),
          duration: 2500,
          splashIconSize: 250,
        ),
      ),
    );
  }
}