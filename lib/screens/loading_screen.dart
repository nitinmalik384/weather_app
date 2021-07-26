import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocationData();
  }

  void getLocationData() async {
    var weatherdata = await WeatherModel().getLocationWeatherData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  locationWeather: weatherdata,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Lottie.asset('assets/splashScreen.json'),
        width: 180,
      )),
    );
  }
}
