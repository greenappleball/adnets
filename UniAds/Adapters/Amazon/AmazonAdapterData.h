//
//  AmazonAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "CustomAdapterData.h"

#define AD_DOMAIN               @"com.AmazonAd_iOS_SDK"

@interface AmazonAdapterData : CustomAdapterData

@property(strong, nonatomic) NSString* appId;
@property(strong, nonatomic) NSNumber* locationUpdateEnabled;

- (BOOL)isLocationUpdateEnabled;

@end
