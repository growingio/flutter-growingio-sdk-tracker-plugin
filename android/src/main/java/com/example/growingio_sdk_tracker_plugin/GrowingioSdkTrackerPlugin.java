package com.example.growingio_sdk_tracker_plugin;

import androidx.annotation.NonNull;

import java.util.Map;

import com.growingio.android.sdk.track.GrowingTracker;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** GrowingioSdkTrackerPlugin */
public class GrowingioSdkTrackerPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "growingio_sdk_tracker_plugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("trackCustomEvent")) {
      onTrackCustomEvent(call);
    } else if (call.method.equals("trackCustomEventItemKeyId")) {
      onTrackCustomEventItemKeyId(call);
    } else if (call.method.equals("setLoginUserAttributes")) {
      onSetLoginUserAttributes(call);
    } else if (call.method.equals("cleanLoginUserId")) {
      onCleanLoginUserId();
    } else if (call.method.equals("setLoginUserId")) {
      onSetLoginUserId(call);
    } else {
      result.notImplemented();
      return;
    }
    result.success(null);
  }

  private void onSetLoginUserAttributes(MethodCall call) {
    GrowingTracker.get().setLoginUserAttributes((Map<String, String>)call.arguments);
  }

  private void onSetLoginUserId(MethodCall call) {
    GrowingTracker.get().setLoginUserId((String)call.argument("userId"));
  }

  private void onCleanLoginUserId() {
    GrowingTracker.get().cleanLoginUserId();
  }

  private void onTrackCustomEvent(MethodCall call) {
    String eventId = (String)call.argument("eventId");
    Map<String, String> variable = null;
    if (call.hasArgument("variable")) {
      variable = call.argument("variable");
    }
    if (variable == null) {
      GrowingTracker.get().trackCustomEvent(eventId);
    } else {
      GrowingTracker.get().trackCustomEvent(eventId, (Map<String, String>)variable);
    }
  }
  private void onTrackCustomEventItemKeyId(MethodCall call) {
    String eventId = (String)call.argument("eventId");
    String itemKey = (String)call.argument("itemKey");
    String itemId = (String)call.argument("itemId");
    Map<String, String> variable = null;
    if (call.hasArgument("variable")) {
      variable = call.argument("variable");
    }
    if (variable == null) {
      GrowingTracker.get().trackCustomEvent(eventId, itemKey, itemId);
    } else {
      GrowingTracker.get().trackCustomEvent(eventId, (Map<String, String>)variable, itemKey, itemId);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
