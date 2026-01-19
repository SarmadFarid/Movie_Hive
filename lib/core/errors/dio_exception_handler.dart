import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String parse(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout : 
      return "Connection time out. Check your Internet." ; 
      case DioExceptionType.connectionError : 
      return "No Internet Connection" ; 
      case DioExceptionType.receiveTimeout : 
      return "Server took too loing to respond." ;
      case DioExceptionType.cancel : 
      return "Request cancelled" ;
      case DioExceptionType.sendTimeout : 
      return "Request timed out" ; 
      case DioExceptionType.badResponse :
      return handleBadRespone(e.response?.statusCode) ;
      default : 
      return "Something went wrong . Please try again" ;
    }

  }
    static String handleBadRespone(int? statuscode) {
       switch (statuscode) {
        case 400 : 
        return "Bad request."; 
        case 401 :
        return "Unathorized. Please try again." ;
        case 403:
        return "Access Forbidden.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal Server Error.";
        default : 
        return "Server error : $statuscode";
       }
    }
}