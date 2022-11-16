// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends WeatherEvent {
  final String nameOfCity;

  const StartEvent(this.nameOfCity);

  @override
  List<Object> get props => [nameOfCity];
}

class SortEvent extends WeatherEvent {
  final String nameOfCity;

  const SortEvent(this.nameOfCity);

  @override
  List<Object> get props => [nameOfCity];
}
