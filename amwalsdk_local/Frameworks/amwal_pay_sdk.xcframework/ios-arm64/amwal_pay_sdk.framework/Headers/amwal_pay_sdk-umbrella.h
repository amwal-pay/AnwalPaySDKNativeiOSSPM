#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AmwalPaySdkPlugin.h"
#import "AmwalSDK.h"

FOUNDATION_EXPORT double amwal_pay_sdkVersionNumber;
FOUNDATION_EXPORT const unsigned char amwal_pay_sdkVersionString[];

