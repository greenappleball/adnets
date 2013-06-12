//
//  MPSmaatoEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 1/23/12.
//  Copyright (c) 2012 Postindustria. All rights reserved.
//

#import "MPSmaatoEventAdapter.h"
#import <iSoma/SOMAAdListenerProtocol.h>
#import <iSoma/SOMABannerViewDelegate.h>
#import <iSoma/SOMABannerView.h>
#import "MPLogging.h"


#pragma mark - Ad definitions

#define AD_DOMAIN               @"com.Smaato_iOS_SDK"

#define kSpaceId                @"spaceId"
#define kPublisherId            @"publisherId"

#define kIdiom      @"idiom"
#define vPhoneIdiom @"phone"


@interface MPSmaatoEventAdapter () <SOMAAdListenerProtocol,SOMABannerViewDelegate> {
    SOMABannerView* _adBannerView;
}

@property(retain, nonatomic) NSDictionary* params;

@end


#pragma mark - Implementation

@implementation MPSmaatoEventAdapter

- (void)dealloc {
    [self releaseBannerViewDelegateSafely];
    self.params = nil;
	[super dealloc];
}

#pragma	mark - Private

- (NSError*) errorWithCode:(NSInteger)code userInfo:(NSDictionary*)info {
    NSDictionary* userInfo = [info isKindOfClass:[NSDictionary class]] ? info : [NSDictionary dictionary];
    return [NSError errorWithDomain:AD_DOMAIN code:code userInfo:userInfo];
}

- (void)releaseBannerViewDelegateSafely {
    [_adBannerView removeAdListener:self];
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
    _adBannerView = [[SOMABannerView alloc] initWithDimension:[self dimention]];

    _adBannerView.adSettings.adspaceId = [self spaceId];
    _adBannerView.adSettings.publisherId = [self publisherId];
    _adBannerView.animationType = kSOMAAnimationTypeNone;
    _adBannerView.adSettings.adType = kSOMAAdTypeAll;
    [_adBannerView setLocationUpdateEnabled:YES];
    [_adBannerView setAutoReloadEnabled:NO];
    
    [_adBannerView addAdListener:self];
    [_adBannerView setDelegate:self];
    [_adBannerView asyncLoadNewBanner];
}

#pragma mark - Smaato SOMAAdListenerProtocol

-(void)onReceiveAd:(id<SOMAAdDownloaderProtocol>)sender withReceivedBanner:(id<SOMAReceivedBannerProtocol>)receivedBanner
{
    if ([receivedBanner status] == kSOMABannerStatusError) {
        MPLogInfo(@"\nSmaato error ad banner retrieval: %@", [receivedBanner errorMessage]);
        NSError* error = [self errorWithCode:[receivedBanner errorCode] userInfo:@{@"userInfo": [receivedBanner errorMessage]}];
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    } else {
        MPLogInfo(@"\nSmaato has successfully loaded a new ad.");
        [self.delegate bannerCustomEvent:self didLoadAd:_adBannerView];
    }
}

#pragma mark - Smaato SOMABannerViewDelegate methods

- (void)landingPageWillBeDisplayed
{
}

- (void)landingPageHasBeenClosed
{
}

@end
