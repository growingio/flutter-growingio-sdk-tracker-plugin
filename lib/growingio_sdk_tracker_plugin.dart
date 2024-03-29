import 'dart:async';
import 'package:flutter/services.dart';

class GrowingTracker {
  static const MethodChannel _channel =
      const MethodChannel('growingio_sdk_tracker_plugin');

  static Future<void> trackCustomEvent(String? eventId, {Map<String, String>? variable}) async {
    if (eventId == null) return;
    Map<String, dynamic> args = {"eventId": eventId};
    if (variable != null) {
      args['variable'] = variable;
    }
    try {
      await _channel.invokeMethod("trackCustomEvent", args);
    } catch(e) {
      print('error :' + e.toString());
    }
  }

  static Future<void> setLoginUserAttributes(Map<String, String>? variable) async {
    if (variable == null) return;
    try {
      await _channel.invokeMethod("setLoginUserAttributes", variable);
    } catch(e) {
      print('error :' + e.toString());
    }
  }

  static Future<void> setVisitorAttributes(Map<String, String>? variable) async {
    if (variable == null) return;
    try {
      await _channel.invokeMethod("setVisitorAttributes", variable);
    } catch(e) {
      print('error :' + e.toString());
    }
  }

  static Future<void> setConversionVariables(Map<String, String>? variable) async {
    if (variable == null) return;
    try {
      await _channel.invokeMethod("setConversionVariables", variable);
    } catch(e) {
      print('error :' + e.toString());
    }
  }

  static Future<void> setLoginUserId(String? userId) async {
    if (userId == null) return;
    try {
      await _channel.invokeMethod("setLoginUserId", {"userId": userId});
    } catch(e) {
      print('error :' + e.toString());
    }
  }

  static Future<void> cleanLoginUserId() async {
    try {
      await _channel.invokeMethod("cleanLoginUserId");
    } catch(e) {
      print('error :' + e.toString());
    }
  }
}
