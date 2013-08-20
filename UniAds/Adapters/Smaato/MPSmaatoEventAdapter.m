//
//  MPSmaatoEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 1/23/12.
//  Copyright (c) 2012 Postindustria. All rights reserved.
//

#import "MPSmaatoEventAdapter.h"
#import <iSoma/iSoma.h>
#import "MPLogging.h"


#pragma mark - Ad definitions

#define AD_DOMAIN               @"com.Smaato_iOS_SDK"

#define kSpaceId                @"spaceId"
#define kPublisherId            @"publisherId"

#define kIdiom      @"idiom"
#define vPhoneIdiom @"phone"


@interface MPSmaatoEventAdapter () <SOMABannerViewDelegate> {
    SOMABannerView* _adBannerView;
}

@property(retain, nonatomic) NSDictionary* params;

@end


#pragma mark - Implementation

@implementation MPSmaatoEventAdapter

- (void)dealloc {
    [self releaseBannerViewDelegateSafely];
    self.params = nil;
}

#pragma	mark - Private

- (NSError*) errorWithCode:(NSInteger)code userInfo:(NSDictionary*)info {
    NSDictionary* userInfo = [info isKindOfClass:[NSDictionary class]] ? info : [NSDictionary dictionary];
    return [NSError errorWithDomain:AD_DOMAIN code:code userInfo:userInfo];
}

- (void)releaseBannerViewDelegateSafely {
    [_adBannerView removeFromSuperview];
    [_adBannerView setDelegate:nil];
    _adBannerView = nil;
}

#pragma	mark -

- (SOMAAdDimension)dimention
{
    return (![self is_iPhone] ? kSOMAAdDimensionLeaderboard : kSOMAAdDimensionDefault);
}

- (NSInteger)spaceId
{
    NSInteger defaultSpaceId = ![self is_iPhone] ? 65773855 : 65773854;
    NSInteger result = defaultSpaceId;
    NSNumber* spaceId = self.params[kSpaceId];
    if (nil != spaceId) {
        result = [spaceId integerValue];
    }
    return result;
}

- (NSInteger)publisherId
{
    NSInteger defaultPublisherId = 923864091;
    NSInteger result = defaultPublisherId;
    NSNumber* publisherId = self.params[kPublisherId];
    if (nil != publisherId) {
        result = [publisherId integerValue];
    }
    return result;
}

- (BOOL)is_iPhone
{
    NSString* idiom = self.params[kIdiom];
    return (idiom && [idiom isEqualToString:vPhoneIdiom]);
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = info;
    [self loadSmaatoSDK];
}

#pragma mark - Smaato 

-(void) loadSmaatoSDK
{
    _adBannerView = [[SOMABannerView alloc] initWithDimension:[self dimention] publisher:[self publisherId] adspace:[self spaceId]];

    // Test ids
//    _adBannerView.adSettings.adspaceId = 0;
//    _adBannerView.adSettings.publisherId = 0;
    _adBannerView.animationType = kSOMAAnimationTypeRandom;
    _adBannerView.adSettings.adType = kSOMAAdTypeImage;
    [_adBannerView setLocationUpdateEnabled:YES];
    [_adBannerView setAutoReloadEnabled:NO];

    [_adBannerView setDelegate:self];
    __weak __typeof(&*self)pointer = self;
    [_adBannerView asyncLoadNewBannerWithCompletionHandler:^(id<SOMAReceivedBanner> receivedBanner, NSError *error) {
        if (error) {
            MPLogInfo(@"\nSmaato error ad banner retrieval: %@", [error localizedDescription]);
            [pointer.delegate bannerCustomEvent:pointer didFailToLoadAdWithError:error];
        } else {
            MPLogInfo(@"\nSmaato has successfully loaded a new ad.");
            [pointer.delegate bannerCustomEvent:pointer didLoadAd:_adBannerView];
        }
    }];
}

#pragma mark - Smaato SOMABannerViewDelegate methods

- (void)landingPageWillBeDisplayed
{
}

- (void)landingPageHasBeenClosed
{
}

@end
