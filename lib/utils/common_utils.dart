import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonUtils {
  // Show a snackbar with a message
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Email Validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegEx = RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$");
    if (!emailRegEx.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Non-empty Validator
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  // Date Formatter (for displaying dates in a readable format)
  static String formatDate(DateTime date) {
    return DateFormat.yMMMMd().format(date); // Example: August 9, 2024
  }

  // Time Formatter (for displaying time in a readable format)
  static String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt); // Example: 2:30 PM
  }

  // Convert Firebase Timestamp to DateTime
  static DateTime convertTimestampToDateTime(dynamic timestamp) {
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    } else if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    throw ArgumentError('Invalid timestamp');
  }

  // Convert DateTime to Firebase Timestamp
  static int convertDateTimeToTimestamp(DateTime date) {
    return date.millisecondsSinceEpoch ~/ 1000;
  }

  // Convert a string to DateTime
  static DateTime? parseDateString(String dateStr, {String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  // Capitalize the first letter of a string
  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
