//
//  InMobiAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 10/22/13.
//
//

#import "InMobiAdapterData.h"

@implementation InMobiAdapterData

#pragma mark - Accessors

- (NSString *)appId
{
#ifdef DEBUG
    NSAssert(_appId, @"Strongly need appId");
#endif
    return _appId;
}

- (NSMutableDictionary *)inmobiExtras
{
    return [@{@"tp": @"c_mopub", @"tp-ver": MP_SDK_VERSION} mutableCopy];
}

@end
