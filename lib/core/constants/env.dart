import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiKeyAndroid => dotenv.env["GOOGLE_API_KEY_ANDROID"] ?? "";
  static String get apiKeyIOS=> dotenv.env["GOOGLE_API_KEY_IOS"] ?? "";
}