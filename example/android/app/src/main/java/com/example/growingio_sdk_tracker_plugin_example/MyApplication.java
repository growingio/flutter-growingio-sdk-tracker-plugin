package com.example.growingio_sdk_tracker_plugin_example;

import com.growingio.android.sdk.track.TrackConfiguration;
import com.growingio.android.sdk.track.GrowingTracker;
import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {
    private static TrackConfiguration sConfiguration;
    @Override
    public void onCreate() {
        super.onCreate();


        if (sConfiguration == null) {
            sConfiguration = new TrackConfiguration("bfc5d6a3693a110d", "growing.d80871b41ef40518")
                    .setUploadExceptionEnabled(false)
                    .setDebugEnabled(true)
                    .setOaidEnabled(false);
        }
        GrowingTracker.startWithConfiguration(this, sConfiguration);
    }
}
