//
//  FlurryAdsWrapper.h
//  Pods
//
//  Created by Dmitri Petrishin on 10/10/13.
//
//

#import "FlurryAds.h"
#import "FlurryAdDelegate.h"
#import <Foundation/Foundation.h>

@interface FlurryAdsWrapper : NSObject
// shared instance
+ (instancetype)sharedInstance;

// container for banner
+ (UIView*)sharedAdView;

// usage for fetching & showing banner
+ (void)fetchAndDisplayAdForSpace:(NSString*)space size:(FlurryAdSize)size inView:(UIView *)viewContainer withDelegate:(id<FlurryAdDelegate>)delegate;

// usage for fetching interstitial
+ (void)fetchAdForSpace:(NSString*)space size:(FlurryAdSize)size withDelegate:(id<FlurryAdDelegate>)delegate;
// usage for showing interstitial
+ (void)displayAdSpace:(NSString*)space inView:(UIView *)viewContainer;
+ (BOOL)adReadyForSpace:(NSString*)space;

// clearing delegates
- (void)removeDelegate:(id<FlurryAdDelegate>)delegate;

@end
