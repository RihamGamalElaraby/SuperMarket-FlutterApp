import 'package:flutter/material.dart';
import 'package:supermarket/screens/onboardingScreen.dart';
import 'package:supermarket/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/blocObserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '  SuperMarket',
      theme: LightTheme,
      darkTheme: DarkTheme,
      themeMode: ThemeMode.dark,
      home: OnBoardingScreen(),
    );
  }
}
