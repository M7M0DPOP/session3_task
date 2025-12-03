import 'dart:convert';

import 'package:dio/dio.dart';

class WorkAreaApi {
  WorkAreaApi._();
  static getRequestOfWorkArea({int page = 1, int limit = 10}) async {
    Response response = await Dio().get(
      'https://nodejs-roaya-api.vercel.app/api/v1/work-areas?page=$page&limit=$limit',
    );
    return jsonDecode(response.toString());
  }
}
