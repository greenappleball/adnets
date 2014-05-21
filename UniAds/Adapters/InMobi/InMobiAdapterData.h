//
//  InMobiAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 10/22/13.
//
//

#import "CustomAdapterData.h"

@interface InMobiAdapterData : CustomAdapterData
@property(strong, nonatomic) NSString* appId;
@property(readonly, nonatomic) NSMutableDictionary* inmobiExtras;
@end
