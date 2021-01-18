package com.example.growingio_sdk_tracker_plugin;

import androidx.annotation.NonNull;
import android.text.TextUtils;

import android.util.Log;
import java.util.Map;

import com.growingio.android.sdk.track.ErrorLog;
import com.growingio.android.sdk.track.GrowingTracker;
import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

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
    if (call.method.equals("trackCustomEvent")){
      onTrackCustomEvent(call);
    }else if (call.method.equals("setConversionVariables")){
      onSetConversionVariables(call);
    }else if (call.method.equals("setLoginUserAttributes")){
      onSetLoginUserAttributes(call);
    }else if (call.method.equals("setVisitorAttributes")) {
      onSetVisitorAttributes(call);
    }else if (call.method.equals("cleanLoginUserId")){
      onCleanLoginUserId();
    }else if (call.method.equals("setLoginUserId")){
      onSetLoginUserId(call);
    }else{
      result.notImplemented();
      return;
    }
    result.success(null);
  }

  private void onSetConversionVariables(MethodCall call){
    GrowingTracker.get().setConversionVariables((Map<String, String>)call.arguments);
  }

  private void onSetLoginUserAttributes(MethodCall call){
    GrowingTracker.get().setLoginUserAttributes((Map<String, String>)call.arguments);
  }

  private void onSetLoginUserId(MethodCall call){
    GrowingTracker.get().setLoginUserId((String)call.argument("userId"));
  }

  private void onCleanLoginUserId(){
    GrowingTracker.get().cleanLoginUserId();
  }

  private void onSetVisitorAttributes(MethodCall call){
    GrowingTracker.get().setVisitorAttributes((Map<String, String>)call.arguments);
  }

  private void onTrackCustomEvent(MethodCall call){
    String eventId = (String) call.argument("eventId");
    Double num = call.argument("num");
    boolean hasNum = call.hasArgument("num");
    GrowingTracker gio = (GrowingTracker) GrowingTracker.get();
    if (call.hasArgument("variable")){
      Map<String, String> variable = call.argument("variable");
      if (variable == null) return;
      gio.trackCustomEvent(eventId, (Map<String, String>) variable);
    }else{
      gio.trackCustomEvent(eventId);
    }
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
