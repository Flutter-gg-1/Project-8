import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Onesignal {
  final dio = Dio();

  pushNote({required String msg , required String userId}) async {
    try {
      final res =
          await dio.post("https://api.onesignal.com/notifications?c=push",
              options: Options(headers: {
                "Authorization":
                    "Basic MmQyZDM3ZmItODMwYi00MDkyLTg2ZGMtMWE2MWVlNjIyNTA3",
                "Content-Type": "application/json"
              }),
              data: {
            "app_id": "98c8beff-b891-42d4-b937-ceb213913cec",
            "target_channel": "push",
            "include_aliases": {
              
              "external_id": [userId],
            },
            "contents": {"en": msg},
          });
    } on DioException catch (er) {
      // log("$er");
      // log("${er.error}");
      // log("${er.message}");
      log("${er.response}");
    }
  }
}
