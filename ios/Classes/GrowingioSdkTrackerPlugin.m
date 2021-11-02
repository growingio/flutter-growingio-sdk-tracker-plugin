#import "GrowingioSdkTrackerPlugin.h"
#import <GrowingAnalytics/GrowingTracker.h>

@implementation GrowingioSdkTrackerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"growingio_sdk_tracker_plugin"
                                                                binaryMessenger:[registrar messenger]];
    GrowingioSdkTrackerPlugin *instance = [[GrowingioSdkTrackerPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  BOOL res = [self methodName:call.method andArguments:call.arguments];
  result(res ? nil : FlutterMethodNotImplemented);
}

- (BOOL)methodName:(NSString *)methodName andArguments:(id)arguments {
    NSDictionary *argDic = arguments;
    if ([methodName isEqualToString:@"trackCustomEvent"]) {
        NSString *eventID = argDic[@"eventId"];
        NSDictionary *variable = argDic[@"variable"];
        if (variable) {
            [[GrowingTracker sharedInstance] trackCustomEvent:eventID withAttributes:variable];
        } else {
            [[GrowingTracker sharedInstance] trackCustomEvent:eventID];
        }
    } else if ([methodName isEqualToString:@"setLoginUserAttributes"]) {
        [[GrowingTracker sharedInstance] setLoginUserAttributes:argDic];
    } else if ([methodName isEqualToString:@"setVisitorAttributes"]) {
        [[GrowingTracker sharedInstance] setVisitorAttributes:argDic];
    } else if ([methodName isEqualToString:@"setConversionVariables"]) {
        [[GrowingTracker sharedInstance] setConversionVariables:argDic];
    } else if ([methodName isEqualToString:@"setLoginUserId"]) {
        NSString *userId = argDic[@"userId"];
        [[GrowingTracker sharedInstance] setLoginUserId:userId];
    } else if ([methodName isEqualToString:@"cleanLoginUserId"]) {
        [[GrowingTracker sharedInstance] cleanLoginUserId];
    } else {
        return NO;
    }
    
    return YES;
}

@end
