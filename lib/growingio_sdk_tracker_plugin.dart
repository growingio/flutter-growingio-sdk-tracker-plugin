
import 'dart:async';

import 'package:flutter/services.dart';

class GrowingTracker {
  static const MethodChannel _channel =
      const MethodChannel('growingio_sdk_tracker_plugin');

  static Future<void> trackCustomEvent(String? eventId,
      {double? num, Map<String, dynamic>? variable}) async {
    if (eventId == null) return;
    Map<String, dynamic> args = {"eventId": eventId};
    if (num != null) {
      args['num'] = num;
    }
    if (variable != null) {
      args['variable'] = variable;
    }
    return await _channel.invokeMethod("trackCustomEvent", args);
  }

  static Future<void> setLoginUserAttributes(Map<String, dynamic>? variable) async {
    if (variable == null) return;
    try {
      return await _channel.invokeMethod("setLoginUserAttributes", variable);
    }
    catch(e) {
      print('error :' + e.toString());
    }
  }

  static Future<void> setVisitorAttributes(Map<String, dynamic>? variable) async {
    if (variable == null) return;
    return await _channel.invokeMethod("setVisitorAttributes", variable);
  }
  static Future<void> setConversionVariables(Map<String, dynamic>? variable) async {
    if (variable == null) return;
    return await _channel.invokeMethod("setConversionVariables", variable);
  }
  static Future<void> setLoginUserId(String? userId) async {
    if (userId == null) return;
    return await _channel.invokeMethod("setLoginUserId", {"userId": userId});
  }
  static Future<void> cleanLoginUserId() async {
    return await _channel.invokeMethod("cleanLoginUserId");
  }

}
