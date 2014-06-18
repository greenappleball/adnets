//
//  RubiconAdapterData.h
//  LifelikeClassifieds
//
//  Created by Dmitri Petrishin on 6/18/14.
//  Copyright (c) 2014 Postindustria. All rights reserved.
//

#import "CustomAdapterData.h"

@interface RubiconAdapterData : CustomAdapterData

@property(strong, nonatomic) NSString* appId;
@property(strong, nonatomic) NSString* pubId;
@property(strong, nonatomic) NSString* adServer;

@end
