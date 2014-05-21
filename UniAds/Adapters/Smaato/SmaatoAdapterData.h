//
//  SmaatoAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "CustomAdapterData.h"

#define AD_DOMAIN       @"com.Smaato_iOS_SDK"

@interface SmaatoAdapterData : CustomAdapterData

@property(strong, nonatomic) NSNumber* spaceId;
@property(strong, nonatomic) NSNumber* publisherId;
@property(strong, nonatomic) NSNumber* locationUpdateEnabled;

- (BOOL)isLocationUpdateEnabled;

@end
