import 'package:flutter/material.dart';

import '../../services/location_service.dart';

class ViewLocationsScreen extends StatefulWidget {
  @override
  _ViewLocationsScreenState createState() => _ViewLocationsScreenState();
}

class _ViewLocationsScreenState extends State<ViewLocationsScreen> {
  final LocationService _locationService = LocationService();
  List<Map<String, String>> _locations = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      List<Map<String, String>> locations = await _locationService.fetchLocations();
      setState(() {
        _locations = locations;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load locations.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Locations')),
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
                  itemCount: _locations.length,
                  itemBuilder: (context, index) {
                    final location = _locations[index];
                    return ListTile(
                      title: Text('${location['country']}, ${location['state']}, ${location['district']}, ${location['city']}'),
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
