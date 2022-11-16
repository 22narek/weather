import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_friflex/bloc/weather_bloc.dart';
import 'package:weather_friflex/repository/weather_repo.dart';
import 'package:weather_friflex/screens/main_screen.dart';
import 'package:weather_friflex/screens/more_screen.dart';
import 'package:weather_friflex/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

//MyApp is the root
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepo(),
      //MultiBlocProvider to combine multiple [BlocProvider] widgets
      //into one widget tree for the future
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc(context.read<WeatherRepo>()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color.fromARGB(237, 137, 198, 248),
          ),
          home: const CitySearchScreen(),
          //named routes for simplicity
          routes: {
            '/second': (context) => const MainScreen(),
            '/third': (context) => const MoreInfoScreen(),
          },
        ),
      ),
    );
  }
}
