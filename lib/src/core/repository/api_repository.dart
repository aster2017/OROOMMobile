import 'dart:async';

import '../constants/api_endpoints.dart';
import '../services/dio_service.dart';

class ApiRepository {
  Future<Map<String, dynamic>?> obtainToken(
      {required String username, required String password}) async {
    try {
      final tokenResponse = await DioService().client.post(
          APIEndpoints.loginUrl,
          data: {"username": username, "password": password});

      if (tokenResponse.statusCode == 200 || tokenResponse.statusCode == 201) {
        return (tokenResponse.data);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }

  Future<Map<String, dynamic>?> getUser({required String userId}) async {
    try {
      final tokenResponse =
          await DioService().client.post("${APIEndpoints.myProfile}/$userId");
      return (tokenResponse.data);
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }

  Future<Map<String, dynamic>?> registerUser(
      {required String username, required String password}) async {
    try {
      final tokenResponse = await DioService()
          .client
          .post(APIEndpoints.registerUrl, data: {
        "username": username,
        "password": password,
        "user_type": "individual"
      });

      if (tokenResponse.statusCode == 200 || tokenResponse.statusCode == 201) {
        return (tokenResponse.data);
      }
    } on DioError catch (e) {
      print(e.response!.data);
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error!";
      } else {
        throw e.response!.statusMessage!;
      }
    } catch (e) {
      print(e.toString());
      throw "Something went wrong!";
    }
  }
}
