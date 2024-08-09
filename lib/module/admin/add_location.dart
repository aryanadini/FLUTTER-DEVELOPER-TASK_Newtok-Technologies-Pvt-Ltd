import 'package:flutter/material.dart';

import '../../services/fetch_data_from_firebase.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? country, state, district, city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Location')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Country',),

                onChanged: (value) => country = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'State'),
                onChanged: (value) => state = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'District'),
                onChanged: (value) => district = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                onChanged: (value) => city = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await LocationService().addLocation(
                      country!,
                      state!,
                      district!,
                      city!,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location Added')));
                  }
                },
                child: Text('Add Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
