
import 'package:flutter/cupertino.dart';
import 'package:machinetest1/services/auth_service.dart';

import 'module/admin/add_location.dart';
import 'module/admin/admin_screen.dart';
import 'module/users/display_data.dart';
import 'module/users/excel_screen.dart';
import 'module/users/view_location_screen.dart';
import 'module/users/weather_rep_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => AuthService().handleAuth(),
  '/admin/dashboard': (context) => AdminDashboardScreen(),
  '/admin/add_location': (context) => AddLocationScreen(),
  '/user/dashboard': (context) => UserDashboardScreen(),
  '/user/upload_excel': (context) => UploadExcelScreen(),
  '/user/weather_report': (context) => WeatherReportScreen(locations: [],),
  '/user/view_locations': (context) => ViewLocationsScreen(),
};
