import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, String>>> fetchLocations() async {
    List<Map<String, String>> locations = [];

    try {
      QuerySnapshot querySnapshot = await _db.collection('locations').get();

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

  addLocation(String s, String t, String u, String v) {}
}
