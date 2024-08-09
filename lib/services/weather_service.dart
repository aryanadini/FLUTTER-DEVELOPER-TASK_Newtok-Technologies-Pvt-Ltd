import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'your_api_key_here';

  Future<http.Response> fetchWeather(String location) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey';
    return await http.get(Uri.parse(url));
  }

// Implement methods to process and return weather data
}
