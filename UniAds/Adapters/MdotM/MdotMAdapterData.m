//
//  MdotMAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "MdotMAdapterData.h"

@implementation MdotMAdapterData

#pragma mark - Accessors

- (NSString *)key
{
    NSString* result = @"68ffb3caed31a0e8692cdaa5f5a209e3";
    return ([self isTesting]?result:(_key?:result));
}

- (NSString *)test
{
    NSString* result = @"0";
    return _test?:result;
}

#pragma mark - super

- (BOOL)isTesting
{
    return ![[self test] isEqualToString:@"0"];
}

@end
