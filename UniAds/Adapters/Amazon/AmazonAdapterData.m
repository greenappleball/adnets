//
//  AmazonAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "AmazonAdapterData.h"

@implementation AmazonAdapterData

#pragma mark - Accessors

- (NSString *)appId
{
    NSString* result = @"sample-app-v1_pub-2";
    return ([self isTesting]?result:(_appId?:result));
}

- (BOOL)isLocationUpdateEnabled
{
    return [self.locationUpdateEnabled boolValue];
}

@end
