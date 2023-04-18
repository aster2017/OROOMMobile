// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(Map<String, dynamic> str) =>
    ResponseModel.fromJson((str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.pageNumber,
    this.pageSize,
    this.firstPage,
    this.lastPage,
    this.totalPages,
    this.totalRecords,
    this.nextPage,
    this.previousPage,
    this.data,
    this.succeeded,
    this.errors,
    this.message,
  });

  final int? pageNumber;
  final int? pageSize;
  final String? firstPage;
  final String? lastPage;
  final int? totalPages;
  final int? totalRecords;
  final String? nextPage;
  final String? previousPage;
  final dynamic data;
  final bool? succeeded;
  final String? errors;
  final String? message;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        firstPage: json["firstPage"],
        lastPage: json["lastPage"],
        totalPages: json["totalPages"],
        totalRecords: json["totalRecords"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        data: json["data"],
        succeeded: json["succeeded"],
        errors: json["errors"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "firstPage": firstPage,
        "lastPage": lastPage,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
        "nextPage": nextPage,
        "previousPage": previousPage,
        "data": data,
        "succeeded": succeeded,
        "errors": errors,
        "message": message,
      };
}
