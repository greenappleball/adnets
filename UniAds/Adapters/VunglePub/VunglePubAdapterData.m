//
//  VunglePubAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 10/17/13.
//
//

#import "VunglePubAdapterData.h"

@interface VunglePubAdapterData ()

@end

@implementation VunglePubAdapterData
@synthesize vgUserData;

#pragma mark - Accessors

- (NSString *)appId
{
#ifdef DEBUG
    NSAssert(_appId, @"Strongly need appId");
#endif
    return _appId;
}

- (VGUserData*)vgUserData
{
    return [VGUserData defaultUserData];
}

@end
