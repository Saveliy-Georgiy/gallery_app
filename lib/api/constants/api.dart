import 'package:flutter/foundation.dart';

class Api {
  Api._();

  static const String baseUrl = 'https://pixabay.com/api';
  static const String pixabayApiKey = '46104914-9bb62297136b4f0c7cfa83b55';
  static const String proxyUrl = kIsWeb ? 'https://cors.eu.org' : '';
}
