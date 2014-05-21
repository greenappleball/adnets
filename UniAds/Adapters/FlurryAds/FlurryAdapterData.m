//
//  FlurryAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "FlurryAdapterData.h"

@implementation FlurryAdapterData

#pragma mark - Accessors

- (NSString *)adSpaceName
{
    NSString* result = @"Strongly need to define adSpaceName!!!";
    return ([self isTesting]?result:(_adSpaceName?:result));
}

@end
