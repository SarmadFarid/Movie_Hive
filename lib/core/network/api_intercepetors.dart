import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_hive/core/network/api_constants.dart';

class ApiIntercepetors extends Interceptor{
 @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

     options.headers['Authorization']  = "Bearer ${ApiConstants.readAccessToken}"; 
     options.headers['Content-Type'] = 'application/json'; 

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Success , statuscode: ${response.statusCode} , ${response.statusMessage} ,  "); 
    super.onResponse(response, handler);
  }
}