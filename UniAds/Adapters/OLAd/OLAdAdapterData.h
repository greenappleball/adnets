//
//  OLAdAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 9/19/13.
//
//

#import "CustomAdapterData.h"

#define AD_DOMAIN       @"com.OneLouderSDK"

#define vCloseButton_hide       @"hide"

@interface OLAdAdapterData : CustomAdapterData

@property(strong, nonatomic) NSString* appId;
@property(strong, nonatomic) NSString* adPlacement;
@property(strong, nonatomic) NSString* closeButton;

- (BOOL)isCloseButtonHide;

@end
