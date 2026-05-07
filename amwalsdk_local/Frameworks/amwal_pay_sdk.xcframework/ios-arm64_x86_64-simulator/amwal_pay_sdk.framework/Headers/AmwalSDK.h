#import "AmwalPaySdkPlugin.h"
#import <Flutter/Flutter.h>

// Main SDK header file
@interface AmwalSDK : NSObject<FlutterPlugin>
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;
@end