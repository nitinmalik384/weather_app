import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature, max_temperature, min_temperature;
  String weatherIcon;
  String cityName, sunrise, sunset;
  String msg;
  String main;
  String description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData != null) {
        dynamic temp = (weatherData['main']['temp']); //-273.1;
        temperature = temp.toInt();
        max_temperature = ((weatherData['main']['temp_max'])).toInt();
        min_temperature = ((weatherData['main']['temp_min'])).toInt();
        var condition = weatherData['weather'][0]['id'];
        sunrise = (weatherData['sys']['sunrise']).toString();

        sunset = (weatherData['sys']['sunset']).toString();

        weatherIcon = weatherModel.getWeatherIcon(condition);
        print("ICON  :  $weatherIcon\n temperature : $temperature");
        msg = weatherModel.getMessage(temperature);

        cityName = weatherData['name'];

        main = weatherData['weather'][0]['main'];
        description = weatherData['weather'][0]['description'];
        //weather[0].description
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData =
                          await weatherModel.getLocationWeatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      String cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contect) => CityScreen()));
                      print(cityName);
                      var weatherData =
                          await weatherModel.getCityWeatherData(cityName);
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                      textAlign: TextAlign.end,
                    ),
                    Container(
                      child: Lottie.asset(weatherIcon),
                      height: 150,
                      width: 150,
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Text(
                    "Max : $max_temperature° / Min : $min_temperature° \nSunrise : $sunrise\nSunset : $sunset\nCondition : $main\nDescription : $description",
                    style: kminmaxTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 100.0),
                child: Text(
                  "$msg in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
