// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weather_friflex/model/weather_model.dart';

class NameOfCity extends StatelessWidget {
  //take our model
  final WeatherModel model;

  const NameOfCity({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        //showing the name of the city
        model.city?.name.toString() ?? '',
        //describing the text style
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
