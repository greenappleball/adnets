//
//  RubiconAdapterData.m
//  LifelikeClassifieds
//
//  Created by Dmitri Petrishin on 6/18/14.
//  Copyright (c) 2014 Postindustria. All rights reserved.
//

#import "RubiconAdapterData.h"

@implementation RubiconAdapterData

- (NSString *)adServer
{
    return @"http://mrp.rubiconproject.com/";
}

- (NSString *)appId
{
    return _appId?:@"8859A770A2330131105922000A93D4E6";
}

- (NSString *)pubId
{
    return _pubId?:@"111008";
}

@end
