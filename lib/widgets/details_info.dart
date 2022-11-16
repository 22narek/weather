// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:weather_friflex/constants/util.dart';
import 'package:weather_friflex/model/weather_model.dart';

class WeatherDetailesWidget extends StatelessWidget {
  //take our model
  final WeatherModel model;
  //index for days of the week
  final int index;

  const WeatherDetailesWidget({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get weather icon
    var iconUrl = model.list?[0].getIconUrl();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //show weather icon
            Image.network(iconUrl ?? ''),
            const SizedBox(width: 10),
            //show the temperature in decimal
            Text(
              "${model.list?[index].temp?.day?.toStringAsFixed(1).toString()} °C",
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Util.getItem(
              //show custom icon
              FontAwesomeIcons.cloudRain,
              //show humidity from our model
              model.list?[index].humidity ?? 1,
              '%',
            ),
            Util.getItem(
              FontAwesomeIcons.wind,
              //show speed from our model
              model.list?[index].speed?.toInt() ?? 1,
              'm/s',
            ),
          ],
        ),
      ],
    );
  }
}
