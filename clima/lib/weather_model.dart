import 'location.dart';
import 'networking.dart';


const String kApiKey = 'bbd0c1871c103c27c971cced82d22192';
const String kBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class Weather {
  Weather({
    required this.city,
    required this.country,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.tempMin,
    required this.tempMax,
    required this.timezoneOffset,
  });

  final String city;
  final String country;
  final String description;
  final String icon; // mã icon của OpenWeatherMap, ví dụ "04d"
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final double tempMin;
  final double tempMax;
  final int timezoneOffset; // giây so với UTC

  // Ánh xạ JSON thành đối tượng Weather
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'] ?? '',
      country: json['sys']?['country'] ?? '',
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      timezoneOffset: (json['timezone'] as num).toInt(),
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  String get localTime {
    final t = DateTime.now().toUtc().add(Duration(seconds: timezoneOffset));
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m ${t.hour >= 12 ? 'PM' : 'AM'} local time';
  }
}

class WeatherService {
  // Thời tiết theo tên thành phố
  Future<Weather> getCityWeather(String cityName) async {
    final url =
        '$kBaseUrl?q=${Uri.encodeComponent(cityName)}&appid=$kApiKey&units=metric';
    return Weather.fromJson(await NetworkHelper(url).getData());
  }

  // Thời tiết theo vị trí hiện tại (GPS)
  Future<Weather> getLocationWeather() async {
    final location = Location();
    await location.getCurrentLocation();
    final url =
        '$kBaseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric';
    return Weather.fromJson(await NetworkHelper(url).getData());
  }
}