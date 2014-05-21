//
//  SmartMadAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "CustomAdapterData.h"

#define AD_DOMAIN               @"com.smartmad.SmartMad_iOS_SDK"

@interface SmartMadAdapterData : CustomAdapterData

@property(strong, nonatomic) NSString* appId;
@property(strong, nonatomic) NSString* banner1;
@property(strong, nonatomic) NSString* banner2;
@property(strong, nonatomic) NSString* id DEPRECATED_ATTRIBUTE;

@end
