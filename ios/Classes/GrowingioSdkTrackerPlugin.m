#import "GrowingioSdkTrackerPlugin.h"
#import "GrowingTracker.h"

@implementation GrowingioSdkTrackerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"growingio_sdk_tracker_plugin"
            binaryMessenger:[registrar messenger]];
  GrowingioSdkTrackerPlugin* instance = [[GrowingioSdkTrackerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  [self methodName:call.method andArguments:call.arguments];
}

//打点事件方法
- (BOOL)methodName:(NSString *)methodName andArguments:(id)arguments{
    NSDictionary *argDic = arguments ;
    if ([methodName isEqualToString:@"trackCustomEvent"]) {
        NSString *eventID = argDic[@"eventId"];
        NSDictionary *variable = argDic[@"variable"];
        NSNumber *num = (NSNumber *)argDic[@"num"];
        if (eventID && variable){
            [[GrowingTracker sharedInstance] trackCustomEvent:eventID withAttributes:variable];
        }else if (eventID){
            [[GrowingTracker sharedInstance] trackCustomEvent:eventID];
        }
    }else if ([methodName isEqualToString:@"trackCustomEventItemKeyId"]) {
        NSString *eventID = argDic[@"eventId"];
        NSDictionary *variable = argDic[@"variable"];
        NSString *itemKey = argDic[@"itemKey"];
        NSString *itemId = argDic[@"itemId"];
        if (eventID && variable){
          [[GrowingTracker sharedInstance] trackCustomEvent:eventID itemKey:itemKey itemId:itemId withAttributes:variable];
        }else if (eventID){
          [[GrowingTracker sharedInstance] trackCustomEvent:eventID itemKey:itemKey itemId:itemId];
        }
    }else if ([methodName isEqualToString:@"setLoginUserAttributes"]) {
        [[GrowingTracker sharedInstance] setLoginUserAttributes:argDic];
    }else if ([methodName isEqualToString:@"setLoginUserId"]) {
        NSString *userId = argDic[@"userId"];
        [[GrowingTracker sharedInstance] setLoginUserId:userId];
    }else if ([methodName isEqualToString:@"cleanLoginUserId"]) {
        NSLog(@"cleanLoginUserId 1");
        [[GrowingTracker sharedInstance] cleanLoginUserId];
    }else {
        NSLog(@"no method 1");
        return NO;
    }
    return YES;
}

@end
