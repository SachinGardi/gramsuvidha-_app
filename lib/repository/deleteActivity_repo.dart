import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class DeleteActivityRepo {
  static String? statusCode;
  static String? statusMessage;
  static var headers = {
    'Content-Type': 'application/json',
  };

  static deleteActivity(int id, int deletedBy) async {
    Uri url = Uri.http(kBaseUrl, '/GramSuvidhaActivity');
    var data = jsonEncode({'id': id, 'deletedBy': deletedBy});
    try {
      http.Response response =
          (await http.delete(url, headers: headers, body: data));
      if (response.statusCode == 200) {
        print(response.body);
        Map res = jsonDecode(response.body);
        statusCode = res['statusCode'];
        statusMessage = res['statusMessage'];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      debugPrintStack();
    }
  }
}
