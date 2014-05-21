//
//  SmaatoAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "SmaatoAdapterData.h"

@implementation SmaatoAdapterData

#pragma mark - Accessors

- (NSNumber*)publisherId
{
    NSNumber* result = @0;
    return ([self isTesting]?result:(_publisherId?:result));
}

- (NSNumber*)spaceId
{
    NSNumber* result = @0;
    return ([self isTesting]?result:(_spaceId?:result));
}

- (BOOL)isLocationUpdateEnabled
{
    return [self.locationUpdateEnabled boolValue];
}

@end
