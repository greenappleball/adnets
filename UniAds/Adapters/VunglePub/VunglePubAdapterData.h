//
//  VunglePubAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 10/17/13.
//
//

#import <vunglepub/vunglepub.h>
#import "CustomAdapterData.h"

@interface VunglePubAdapterData : CustomAdapterData

@property(strong, nonatomic) NSString* appId;
@property(readonly, nonatomic) VGUserData* vgUserData;

@end
