import 'package:cine_flow/core/network/api_constants.dart';

class ImageHelper {
  static String getPosterUrl(String path) {
    if(path.isEmpty) return  "";
    return "${ApiConstants.imageBaseUrl}$path"; 
  }
}