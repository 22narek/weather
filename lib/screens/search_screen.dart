import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_friflex/bloc/weather_bloc.dart';
import 'package:weather_friflex/bloc/weather_event.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  //Create a private controller for an editable text field.
  final TextEditingController _cityNameController = TextEditingController();

  //close the controller
  @override
  void dispose() {
    // TODO: implement dispose
    _cityNameController.dispose();
    super.dispose();
  }

  //deletes the text after leaving the page
  void clearText() {
    _cityNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  //assign a controller to a Textfield
                  controller: _cityNameController,
                  style: const TextStyle(color: Colors.white),
                  //Textfield design
                  decoration: InputDecoration(
                    labelText: 'Укажите город',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                //adding a Bloc event with the controller text
                context
                    .read<WeatherBloc>()
                    .add(StartEvent(_cityNameController.text));
                //refresh the TextField
                clearText();
                //go to the second screen
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Подтвердить'),
            ),
          ],
        ),
      ),
    );
  }
}
