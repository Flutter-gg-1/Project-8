import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Onesignal {
  final dio = Dio();

  pushNote({required String msg, required String userId}) async {
    try {
      final res =
          await dio.post("https://api.onesignal.com/notifications?c=push",
              options: Options(headers: {
                "Authorization": "Basic ${dotenv.env["onesignal_api_key"]}",
                "Content-Type": "application/json"
              }),
              data: {
            "app_id": dotenv.env["onesignal_app_key"],
            "target_channel": "push",
            "include_aliases": {
              "external_id": [userId],
            },
            "contents": {"en": msg},
          });
    } on DioException catch (er) {}
  }
}
