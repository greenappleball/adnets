//
//  OLAdAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/19/13.
//
//

#import "OLAdAdapterData.h"

@implementation OLAdAdapterData

#pragma mark - Accessors

- (NSString *)appId
{
    NSString* result = @"craigslist";
    return ([self isTesting]?result:(_appId?:result));
}

- (NSString *)adPlacement
{
    NSString* result = @"global";
    return ([self isTesting]?result:(_adPlacement?:result));
}

- (NSString *)closeButton
{
    NSString* result = @"no";
    return ([self isTesting]?result:(_closeButton?:result));
}

#pragma mark - Public

- (BOOL)isCloseButtonHide
{
    return [self.closeButton isEqualToString:vCloseButton_hide];
}

@end
