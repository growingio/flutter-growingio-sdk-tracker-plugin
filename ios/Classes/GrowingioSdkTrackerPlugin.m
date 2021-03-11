#import "GrowingioSdkTrackerPlugin.h"
#import <GrowingAnalytics/GrowingTracker.h>

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
    }else if ([methodName isEqualToString:@"setLoginUserAttributes"]) {
        NSLog(@"Handler setLoginUserAttributes");
        [[GrowingTracker sharedInstance] setLoginUserAttributes:argDic];
    }else if ([methodName isEqualToString:@"setVisitorAttributes"]) {
        [[GrowingTracker sharedInstance] setVisitorAttributes:argDic];
    }else if ([methodName isEqualToString:@"setConversionVariables"]) {
        [[GrowingTracker sharedInstance] setVisitorAttributes:argDic];
    }else if ([methodName isEqualToString:@"setLoginUserId"]) {
        NSString *userId = argDic[@"userId"];
        [[GrowingTracker sharedInstance] setLoginUserId:userId];
    }else if ([methodName isEqualToString:@"cleanLoginUserId"]) {
        [[GrowingTracker sharedInstance] cleanLoginUserId];
    }else {
        return NO;
    }
    return YES;
}

@end
