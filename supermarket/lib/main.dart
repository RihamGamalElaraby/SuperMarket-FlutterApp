import 'package:flutter/material.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/screens/onboardingScreen.dart';
import 'package:supermarket/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/blocObserver.dart';
import 'package:supermarket/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp(
    BlocProvider(
      create: (context) => SuperMarketCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            title: 'SuperMarket',
            theme: LightTheme,
            darkTheme: DarkTheme,
            themeMode: BlocProvider.of<SuperMarketCubit>(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: OnBoardingScreen(),
          );
        });
  }
}
