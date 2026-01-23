import 'dart:convert';

import 'package:cine_flow/core/utills/app_imports.dart' hide Response;
import 'package:dio/dio.dart';

class ApiIntercepetors extends Interceptor {
  final cacheBox = Hive.box("api_cache");

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final bool isSearchReq = options.path.contains('search');
    if (!isSearchReq) {
      String? oldEtag = cacheBox.get("${options.uri}_etag");
      if (oldEtag != null) {
        options.headers['If-None-Match'] = oldEtag;
        // log(oldEtag);
      }
    }
    options.headers['Authorization'] = "Bearer ${ApiConstants.readAccessToken}";
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }



  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final bool isGetRequest = response.requestOptions.method == "GET";
    final List<String> noCachePaths = ['search'];
    final bool isNoCache = noCachePaths.any(
      (path) => response.requestOptions.path.contains(path),
    );
    if (response.statusCode == 200 && isGetRequest && !isNoCache) {
      String? newEtag = response.headers.value('etag');
      if (newEtag != null) {
        cacheBox.put("${response.requestOptions.uri}_etag", newEtag);
        // log(newEtag);
      }
      cacheBox.put("${response.requestOptions.uri}_data", response.data);
    } else if (isNoCache) {
      log("Skipping cache for result .");
    }
    log(
      "Success , statuscode: ${response.statusCode} , ${response.statusMessage} ,  ",
    );
    super.onResponse(response, handler);
  }



  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 304) {
      log("Data not modified");
      final cachedData = cacheBox.get('${err.requestOptions.uri}_data');
      final senitizedData  = jsonDecode(jsonEncode(cachedData)); 
      final successResponse = Response(
        requestOptions: err.requestOptions,
        statusCode: 200,
        data: senitizedData,
        statusMessage: "From Cache (Not Modified)",
      );
      return handler.resolve(successResponse);
    }
    handler.next(err);
  }
}
