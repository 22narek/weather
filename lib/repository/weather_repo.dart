import 'dart:convert';

import 'package:weather_friflex/constants/app_consts.dart';
import 'package:weather_friflex/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  Future<WeatherModel> getWeather(String query) async {
    var parameters = {
      'appid': Consts.APP_ID,
      'q': query,
      'units': 'metric',
    };

    var weatherRequest = Uri.https(
      Consts.URL_DOMAIN,
      Consts.FORECAST_PATH,
      parameters,
    );
    // print('weatherRequest: $weatherRequest');

    var response = await http.get(weatherRequest);
    // print('weatherResponse: ${response.body}');

    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      // print(response.reasonPhrase);
      // print('chto to');
      throw Exception('Error');
      //   return WeatherModel();
      // }
    }
  }
}
