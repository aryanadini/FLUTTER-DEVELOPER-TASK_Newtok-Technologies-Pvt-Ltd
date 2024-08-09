import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

class ExcelService {
  Future<List<Map<String, String>>> parseExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);

    if (result != null) {
      var bytes = result.files.first.bytes;
      var excel = Excel.decodeBytes(bytes!);
      List<Map<String, String>> locations = [];

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        for (var row in sheet!.rows) {
          locations.add({
            'country': row[0]?.value.toString() ?? '',
            'state': row[1]?.value.toString() ?? '',
            'district': row[2]?.value.toString() ?? '',
            'city': row[3]?.value.toString() ?? '',
          });
        }
      }
      return locations;
    }
    return [];
  }

// Implement other file handling methods as needed
}
