import 'package:dio/dio.dart';
import 'package:cine_flow/core/network/api_constants.dart';
import 'package:cine_flow/core/network/api_intercepetors.dart';

class DioClient {
 static final DioClient _singleton = DioClient._internal(); 
 factory DioClient() => _singleton ;

 late Dio _dio; 
 Dio get dio => _dio ;

 DioClient._internal() {
  BaseOptions options = BaseOptions(
   baseUrl: ApiConstants.baseUrl, 
   sendTimeout: const Duration(seconds: 5), 
   receiveTimeout: const Duration(seconds: 5), 
  );

  _dio = Dio(options); 
  _dio.interceptors.add(ApiIntercepetors()); 
 }
}