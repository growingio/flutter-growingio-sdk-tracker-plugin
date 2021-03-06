#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <GrowingAnalytics/GrowingTracker.h>
#import <GrowingAnalytics/GrowingTrackConfiguration.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    GrowingTrackConfiguration *configuration = [GrowingTrackConfiguration configurationWithProjectId:@"0a1b4118dd954ec3bcc69da5138bdb96"];
    configuration.debugEnabled = YES;
    
    [GrowingTracker startWithConfiguration:configuration launchOptions:launchOptions];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
