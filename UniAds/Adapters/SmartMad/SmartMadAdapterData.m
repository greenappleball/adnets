//
//  SmartMadAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "SmartMadAdapterData.h"

@implementation SmartMadAdapterData

#pragma mark - Accessors

- (NSString *)appId
{
    NSString* result = @"e5eee68390816c19";
    return ([self isTesting]?result:(_appId?:result));
}

- (NSString *)banner1
{
    NSString* result = @"90014245"; // FlipClock iPad
    return ([self isTesting]?result:(_banner1?:result));
}

- (NSString *)banner2
{
    NSString* result = @"90014246"; // FlipClock iPad
    return ([self isTesting]?result:(_banner2?:result));
}

@end
