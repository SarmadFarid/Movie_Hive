import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? "";
  static String get imageBaseUrl => dotenv.env['IMAGE_BASE_URL'] ?? "";
  static String get apikey => dotenv.env['API_KEY'] ?? "";
  static String get readAccessToken => dotenv.env['ACCESS_TOKEN'] ?? "";
}
