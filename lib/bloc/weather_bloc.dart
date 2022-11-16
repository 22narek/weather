// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_friflex/bloc/weather_event.dart';
import 'package:weather_friflex/bloc/weather_state.dart';
import 'package:weather_friflex/constants/sorted.dart';
import 'package:weather_friflex/model/weather_model.dart';
import 'package:weather_friflex/repository/weather_repo.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo repo;

  WeatherBloc(this.repo) : super(WeatherLoadingState()) {
    on<StartEvent>((event, emit) async {
      //checking connectivity
      ConnectivityResult connectivityResult =
          await (Connectivity().checkConnectivity());

      //calling the WeatherLoadingState while data is being received
      emit(WeatherLoadingState());
      if (connectivityResult.name != 'none') {
        try {
          final WeatherModel weather = await repo.getWeather(event.nameOfCity);

          //when the data is received,
          //we call the WheatherLoaded state and pass this data to it
          emit(WeatherLoadedState(model: weather));
        } catch (e) {
          //If the request was executed with an error,
          //then we call the WeatherErrorState
          emit(WeatherErrorState(mesasge: e.toString()));
        }
      } else {
        emit(WeatherErrorState(mesasge: 'no connection'));
      }
    });

    //the same thing with only one difference, we have sorting
    on<SortEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final WeatherModel weather = await repo.getWeather(event.nameOfCity);

        //sorting data
        var sort = Sort().sortData(weather);

        //initialize a new variable and call the copyWith
        final WeatherModel sortedWeather = weather.copyWith(list: sort);

        //after that call WeatherLoadedState
        emit(WeatherLoadedState(model: sortedWeather));
      } catch (e) {
        emit(WeatherErrorState(mesasge: e.toString()));
      }
    });
  }
}
