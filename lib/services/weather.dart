import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeatherData(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=b4576b95f6dd25f4778a758290a4b8d1&units=metric");
    var weatherdata = await networkHelper.getData();
    print(weatherdata);
    return weatherdata;
  }

  Future<dynamic> getLocationWeatherData() async {
    Location location = Location();
    await location.getCurrentLocations();

    NetworkHelper networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=b4576b95f6dd25f4778a758290a4b8d1&units=metric");
    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'assets/thunder.json';
    } else if (condition < 400) {
      return 'assets/drizzle.json';
    } else if (condition < 600) {
      return 'assets/rain.json';
    } else if (condition < 700) {
      return 'assets/snow.json';
    } else if (condition < 800) {
      return 'assets/fog.json';
    } else if (condition == 800) {
      return 'assets/clear.json';
      ;
    } else if (condition <= 804) {
      return 'assets/cloudy.json';
      ;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
