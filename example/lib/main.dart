import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:growingio_sdk_tracker_plugin/growingio_sdk_tracker_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FlatButton(onPressed: this.onPressed, child: new Text(this.text, style: TextStyle(fontSize: 20.0),));
  }

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // String platformVersion;
    // // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   platformVersion = await GrowingioSdkTrackerPlugin.platformVersion;
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }
    //
    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;
    //
    // setState(() {
    //   _platformVersion = 'platformVersion';
    // });
  }

  void _clickTrack(){
    GrowingTracker.trackCustomEvent('eventId');
    GrowingTracker.trackCustomEvent('testEventId', variable: {'testKey': 'testValue', 'testNumKey': '233'});
  }

  void _clickSetLoginUserAttributes(){
    GrowingTracker.setLoginUserAttributes({
      'testKey': 'testValue', 'testNumKey': '2333'
    });
  }

  void _clickSetVisitorAttributes(){
    GrowingTracker.setVisitorAttributes({
      'testKey': 'testValue', 'testNumKey': '2333'
    });
  }

  void _clickSetConversionVariables(){
    GrowingTracker.setConversionVariables({
      'testKey': 'testValue', 'testNumKey': '2333'
    });
  }

  void _clickSetLoginUserId(){
    GrowingTracker.setLoginUserId("testUserId");
  }

  void _clickCleanLoginUserId(){
    GrowingTracker.cleanLoginUserId();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new MyButton(text: "trackCustomEvent", onPressed: _clickTrack),
                new MyButton(text: "setLoginUserAttributes", onPressed: _clickSetLoginUserAttributes),
                new MyButton(text: "setVisitorAttributes", onPressed: _clickSetVisitorAttributes),
                new MyButton(text: "setConversionVariables", onPressed: _clickSetConversionVariables),
                new MyButton(text: "setLoginUserId", onPressed: _clickSetLoginUserId),
                new MyButton(text: "cleanLoginUserId", onPressed: _clickCleanLoginUserId)
              ],
          ),
        ),
      ),
    );
  }
}
