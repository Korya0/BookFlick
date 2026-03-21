import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Formats a date string into a specified pattern using intl.
/// [inputDate]: The raw date string to parse (e.g., "2025-02-15").
/// [outputFormat]: The desired output pattern (e.g., 'yyyy' for year, 'MMM' for month, 'd' for day).
/// [fallback]: The string to return if parsing fails (defaults to empty string).
String formatDate(
  String? inputDate, {
  String outputFormat = 'MMM d, yyyy',
  String fallback = '',
}) {
  // First check for common non-date values
  if (inputDate == null ||
      inputDate.isEmpty ||
      inputDate.trim().isEmpty ||
      inputDate.toLowerCase() == 'no date' ||
      inputDate.toLowerCase() == 'unknown') {
    return fallback;
  }

  // Supported input formats for parsing
  const supportedFormats = [
    'yyyy-MM-dd', // ISO 8601 (common in APIs)
    'MMM d, yyyy', // e.g., "Feb 15, 2019"
    'MM/dd/yyyy', // US format
    'dd/MM/yyyy', // European format
    'yyyyMMdd', // Compact format
    'EEE, dd MMM yyyy', // e.g., "Fri, 15 Feb 2019"
    'yyyy-MM-ddTHH:mm:ssZ', // ISO with time
  ];

  DateTime? parsedDate;

  // Try strict parsing with supported formats
  for (final format in supportedFormats) {
    parsedDate = _tryParseStrict(inputDate, format);
    if (parsedDate != null) break;
  }

  // Try parsing as a timestamp if strict parsing fails
  parsedDate ??= _tryParseTimestamp(inputDate);

  // Try loose parsing as a last resort
  parsedDate ??= _tryParseLoose(inputDate);

  if (parsedDate == null) {
    // For debugging purposes only - remove in production if not needed
    debugPrint('Failed to parse date: "$inputDate"');
    return fallback;
  }

  // Format the parsed date into the requested output format
  return DateFormat(outputFormat).format(parsedDate);
}

////////////////////////////////////////////////////////////////
/// Checks if a parsed date falls within a reasonable range.
bool _isDateReasonable(DateTime date) {
  final now = DateTime.now();
  final earliestReasonable = DateTime(1900);
  final latestReasonable = now.add(const Duration(days: 365 * 10)); // +10 years

  return date.isAfter(earliestReasonable) && date.isBefore(latestReasonable);
}

/// Attempts to parse a date string strictly using a specific format.
DateTime? _tryParseStrict(String input, String format) {
  try {
    final date = DateFormat(format).parseStrict(input);
    return _isDateReasonable(date) ? date : null;
  } catch (_) {
    return null;
  }
}

/// Attempts to parse a date string loosely with DateTime.tryParse.
DateTime? _tryParseLoose(String input) {
  try {
    final date = DateTime.tryParse(input);
    return date != null && _isDateReasonable(date) ? date : null;
  } catch (_) {
    return null;
  }
}

/// Attempts to parse a date from a numeric timestamp (seconds or milliseconds).
DateTime? _tryParseTimestamp(String input) {
  final timestamp = int.tryParse(input);
  if (timestamp == null) return null;

  const maxSecondsTimestamp = 2000000000; // ~2033 in seconds
  const maxMillisecondsTimestamp = 2000000000000; // ~2033 in milliseconds

  if (timestamp > 0) {
    if (timestamp < maxSecondsTimestamp) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    } else if (timestamp < maxMillisecondsTimestamp) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
  }
  return null;
}
