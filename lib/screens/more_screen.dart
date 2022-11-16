import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_friflex/bloc/weather_bloc.dart';
import 'package:weather_friflex/bloc/weather_state.dart';
import 'package:weather_friflex/constants/util.dart';
import 'package:weather_friflex/model/weather_model.dart';
import 'package:weather_friflex/widgets/city_info.dart';
import 'package:weather_friflex/widgets/details_info.dart';
import 'package:weather_friflex/widgets/indicator.dart';

class MoreInfoScreen extends StatelessWidget {
  const MoreInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoadingState) {
          return const OwnProgressIndicator();
        } else if (state is WeatherLoadedState) {
          WeatherModel weatherInfo = state.model;
          return Column(
            children: [
              //widget that displays the names of cities
              NameOfCity(model: weatherInfo),
              const SizedBox(height: 20),
              const Text(
                'Погода за 3 дня',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 100),
              Container(
                height: height / 3.2,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // creates a fixed-length scrollable linear array
                child: ListView.separated(
                  //separator widget
                  separatorBuilder: ((context, index) =>
                      const SizedBox(width: 10)),
                  // itemCount = 3 because we only need to sort for three days
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    //getting the date
                    var short = state.model.list?[index].dt;
                    var dateTime =
                        DateTime.fromMillisecondsSinceEpoch(short! * 1000);
                    // print('temp: ${state.model.list?[index].temp!.day}');
                    return Container(
                      //container design
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                        color: const Color.fromRGBO(235, 235, 235, 0.2),
                      ),
                      width: width / 1.5,
                      //container info
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //showing date
                          Text(
                            Util.getDate(dateTime),
                            style: const TextStyle(color: Colors.white),
                          ),
                          //weather data
                          WeatherDetailesWidget(
                              model: state.model, index: index),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        } else if (state is WeatherErrorState) {
          //showing error state
          return const Center(
            child: Text(
              'Ошибка',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
          );
        }
        return const OwnProgressIndicator();
      }),
    );
  }
}
