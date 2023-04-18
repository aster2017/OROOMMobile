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
        throw "Invalid User Credentials";
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
      print(e.response!);
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

  Future<Map<String, dynamic>?> sendOtp({required String email}) async {
    try {
      final tokenResponse = await DioService()
          .client
          .post(APIEndpoints.sendOtp, queryParameters: {"Email": email});
      return (tokenResponse.data);
    } on DioError catch (e) {
      print(e.toString());
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

  Future<Map<String, dynamic>?> verifyOtp(
      {required String email, required String token}) async {
    try {
      final tokenResponse = await DioService().client.post(
          APIEndpoints.confirmOtp,
          queryParameters: {"email": email, "token": token});
      return (tokenResponse.data);
    } on DioError catch (e) {
      print(e.toString());
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

  Future<Map<String, dynamic>?> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNo,
  }) async {
    try {
      final tokenResponse =
          await DioService().client.post(APIEndpoints.registerUrl, data: {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNo": phoneNo
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

  Future<Map<String, dynamic>?> editUser({
    required String firstName,
    required String lastName,
    required String phoneNo,
    required String id,
    required String userName,
    required String email,
    required bool emailConfirmed,
    required bool phoneNumberConfirmed,
    required String locale,
    required String orgId,
    required String countryID,
    required String stateID,
    required String cityID,
    required String address1,
  }) async {
    try {
      final tokenResponse =
          await DioService().client.put(APIEndpoints.myProfile, data: {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNo,
        "id": id,
        "userName": userName,
        "email": email,
        "emailConfirmed": emailConfirmed,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "locale": locale,
        "countryID": countryID,
        "stateID": stateID,
        "cityID": cityID,
        "address1": address1,
        "orgId": orgId
      });

      return (tokenResponse.data);
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
