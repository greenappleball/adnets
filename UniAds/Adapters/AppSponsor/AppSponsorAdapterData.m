//
//  AppSponsorAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 11/5/13.
//
//

#import "AppSponsorAdapterData.h"

@implementation AppSponsorAdapterData

#pragma mark - Accessors

- (NSString *)zoneId
{
#ifdef DEBUG
    NSAssert(_zoneId, @"Strongly need zoneId");
#endif
    return _zoneId;
}

@end
