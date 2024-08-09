import 'package:flutter/material.dart';

import '../../services/exel_service.dart';


class UploadExcelScreen extends StatefulWidget {
  @override
  _UploadExcelScreenState createState() => _UploadExcelScreenState();
}

class _UploadExcelScreenState extends State<UploadExcelScreen> {
  final ExcelService _excelService = ExcelService();
  List<Map<String, String>> _locations = [];
  bool _loading = false;
  String _errorMessage = '';

  Future<void> _uploadAndParseFile() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      List<Map<String, String>> locations = await _excelService.parseExcelFile();
      setState(() {
        _locations = locations;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to upload or parse the file.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Excel File')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _uploadAndParseFile,
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Upload and Parse Excel'),
            ),
            if (_errorMessage.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            ],
            if (_locations.isNotEmpty) ...[
              SizedBox(height: 20),
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
