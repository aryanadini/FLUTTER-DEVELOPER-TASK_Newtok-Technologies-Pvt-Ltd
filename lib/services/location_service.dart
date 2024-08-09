import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a location to Firestore
  Future<void> addLocation(String country, String state, String district, String city) async {
    await _firestore.collection('locations').add({
      'country': country,
      'state': state,
      'district': district,
      'city': city,
    });
  }

  // Method to fetch all locations from Firestore
  Future<List<Map<String, String>>> fetchLocations() async {
    List<Map<String, String>> locations = [];

    try {
      // Fetch all documents from the 'locations' collection
      QuerySnapshot querySnapshot = await _firestore.collection('locations').get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        locations.add({
          'country': data['country'] ?? '',
          'state': data['state'] ?? '',
          'district': data['district'] ?? '',
          'city': data['city'] ?? '',
        });
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }

    return locations;
  }
}
