import 'package:flutter/material.dart';

import '../../services/weather_service.dart';

class WeatherReportScreen extends StatefulWidget {
  final List<String> locations;

  WeatherReportScreen({required this.locations});

  @override
  _WeatherReportScreenState createState() => _WeatherReportScreenState();
}

class _WeatherReportScreenState extends State<WeatherReportScreen> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic> _weatherData = {};
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherReports();
  }

  Future<void> _fetchWeatherReports() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      Map<String, dynamic> data = {};
      for (String location in widget.locations) {
        final response = await _weatherService.fetchWeather(location);

        if (response.statusCode == 200) {
          data[location] = response.body; // You can parse this response to get specific fields
        } else {
          data[location] = 'Error: ${response.statusCode}';
        }
      }
      setState(() {
        _weatherData = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch weather data.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            if (_loading) ...[
              Center(child: CircularProgressIndicator()),
            ] else if (_errorMessage.isNotEmpty) ...[
              Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red))),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: widget.locations.length,
                  itemBuilder: (context, index) {
                    final location = widget.locations[index];
                    final weatherInfo = _weatherData[location];
                    return ListTile(
                      title: Text(location),
                      subtitle: Text(weatherInfo.toString()),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
