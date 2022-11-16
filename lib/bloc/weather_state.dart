// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:weather_friflex/model/weather_model.dart';

abstract class WeatherState extends Equatable {}

class WeatherLoadingState extends WeatherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final WeatherModel model;
  // final List<ListModel> list;

  WeatherLoadedState({
    required this.model,
    // required this.list,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [model];
}

class WeatherErrorState extends WeatherState {
  final String mesasge;

  WeatherErrorState({
    required this.mesasge,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [mesasge];
}
