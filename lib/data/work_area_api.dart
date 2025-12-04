import 'dart:convert';

import 'package:dio/dio.dart';

class WorkAreaApi {
  WorkAreaApi._();
  static getRequestOfWorkArea({int page = 1, int limit = 2}) async {
    Response
    response = await Dio(BaseOptions(connectTimeout: Duration(seconds: 10))).get(
      'https://nodejs-roaya-api.vercel.app/api/v1/work-areas?page=$page&limit=$limit',
    );
    return jsonDecode(response.toString());
  }
}
