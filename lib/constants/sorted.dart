import 'package:weather_friflex/model/weather_model.dart';

//sorting function
class Sort {
  List<ListModel> sortData(WeatherModel weatherModel) {
    var newList = weatherModel.list!.sublist(0, 3);
    newList.sort((a, b) => a.temp!.day!.compareTo(b.temp!.day!));
    return newList;
  }
}
