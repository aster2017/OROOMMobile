import 'package:dio/dio.dart' as don;
import 'package:get/get.dart';
import 'package:orb/src/core/cache_manager.dart';

import '../../features/splash/splash.dart';
import '../authentication_manager.dart';
import '../constants/api_endpoints.dart';

export 'package:dio/dio.dart';

class DioService with CacheManager {
  factory DioService() => _instance;
  DioService._internal();
  static final DioService _instance = DioService._internal();
  final don.Dio client = don.Dio();

  Future<void> initialize() async {
    client
      ..options.baseUrl = APIEndpoints.baseUrl
      ..interceptors.add(
        don.InterceptorsWrapper(onRequest:
            (requestOptions, requestInterceptorHandler) {
          final _token = getToken();
          if (_token == null || _token.isEmpty) {
            requestOptions.headers.addAll(
              <String, String>{
                'Content-Type': 'application/json',
                'Accept': 'text/plain'
              },
            );
          } else {
            requestOptions.headers.addAll(
              <String, String>{
                'Authorization': 'Bearer $_token',
                'Content-Type': 'application/json',
                'Accept': 'application/json'
              },
            );
          }
          return requestInterceptorHandler.next(requestOptions);
        }, onError:
            (don.DioError error, don.ErrorInterceptorHandler handler) async {
          final _token = getToken();
          if ((error.response?.statusCode == 401 && (_token != null))) {
            AuthenticationManager authController =
                Get.find<AuthenticationManager>();
            authController.logOut();
            Get.offAll(SplashPage());
          }
          handler.next(error);
        }),
      );
  }
}
