import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_friflex/bloc/weather_bloc.dart';
import 'package:weather_friflex/bloc/weather_event.dart';
import 'package:weather_friflex/bloc/weather_state.dart';
import 'package:weather_friflex/model/weather_model.dart';
import 'package:weather_friflex/widgets/city_info.dart';
import 'package:weather_friflex/widgets/details_info.dart';
import 'package:weather_friflex/widgets/indicator.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //SnackBar in case there is an error from the api
    //or there is no internet
    var snackBar = SnackBar(
      content: const Text('Ошибка получения данных'),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 10),
      //return back to the search screen
      action: SnackBarAction(
        label: '↩️',
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
      ),
    );
    return Scaffold(
      //MultiBlocListener because SnackBar works with it
      body: MultiBlocListener(
        listeners: [
          BlocListener<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state is! WeatherErrorState) return;
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return const OwnProgressIndicator();
            } else if (state is WeatherLoadedState) {
              //If state is a Weatherloader,
              //then it stores the weatherModel property, in which weather data is stored
              WeatherModel weatherInfo = state.model;
              var cityName = weatherInfo.city?.name.toString();

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Weather'),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  //action button to go to the third screen
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.view_week),
                      onPressed: () {
                        //adding a Bloc sort event with the city name
                        context
                            .read<WeatherBloc>()
                            .add(SortEvent(cityName ?? ''));
                        Navigator.pushNamed(context, '/third');
                      },
                    )
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //widget that displays the names of cities
                    NameOfCity(model: weatherInfo),
                    const SizedBox(height: 30),
                    //widget that displays information about the weather
                    WeatherDetailesWidget(model: weatherInfo, index: 0),
                  ],
                ),
              );
            } else if (state is WeatherErrorState) {
              // show the error state
              return const Center(
                child: Text(
                  'Ошибка получения данных',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              );
            }
            return const OwnProgressIndicator();
          },
        ),
      ),
    );
  }
}
