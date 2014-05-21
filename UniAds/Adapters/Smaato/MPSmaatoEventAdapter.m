//
//  MPSmaatoEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 1/23/12.
//  Copyright (c) 2012 Postindustria. All rights reserved.
//

#import "MPSmaatoEventAdapter.h"
#import "SmaatoAdapterData.h"
#import <iSoma.h>
#import "MPLogging.h"

@interface MPSmaatoEventAdapter () <SOMABannerViewDelegate>

@property(strong, nonatomic) SOMABannerView* adBannerView;
@property(strong, nonatomic) SmaatoAdapterData* params;

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
    [self.adBannerView asyncLoadNewBannerWithCompletionHandler:nil];
    [self.adBannerView setDelegate:nil];
    [self.adBannerView removeFromSuperview];
    self.adBannerView = nil;
}

#pragma	mark -

- (SOMAAdDimension)dimention
{
    return (![self.params isPhone] ? kSOMAAdDimensionLeaderboard : kSOMAAdDimensionDefault);
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = [SmaatoAdapterData dataWithInfo:info];
    // Test mode
//    self.params.isTestMode = @"yes";
    [self loadSmaatoSDK];
}

#pragma mark - Smaato 

-(void) loadSmaatoSDK
{
    self.adBannerView = [[SOMABannerView alloc] initWithDimension:[self dimention] publisher:[[self.params publisherId] integerValue] adspace:[[self.params spaceId] integerValue]];

    [self.adBannerView setLocationUpdateEnabled:[self.params isLocationUpdateEnabled]];
    self.adBannerView.animationType = kSOMAAnimationTypeRandom;
    self.adBannerView.adSettings.adType = kSOMAAdTypeAll;
    [self.adBannerView setAutoReloadEnabled:NO];

    [self.adBannerView setDelegate:self];
    __weak __typeof(&*self)weakSelf = self;
    [self.adBannerView asyncLoadNewBannerWithCompletionHandler:^(id<SOMAReceivedBanner> receivedBanner, NSError *error) {
        if (error) {
            MPLogInfo(@"\nSmaato error ad banner retrieval: %@", [error localizedDescription]);
            [weakSelf.delegate bannerCustomEvent:weakSelf didFailToLoadAdWithError:error];
        // Pass video and richmedia ads - wrong displayed
        } else if (kSOMAAdTypeVideo == [receivedBanner adType] ||
                   kSOMAAdTypeRichMedia == [receivedBanner adType]) {
            MPLogInfo(@"\nSmaato interstitial ad retrieval VideoAd or RichMedia - pass banner");
            [weakSelf.delegate bannerCustomEvent:weakSelf didFailToLoadAdWithError:nil];
        } else {
            MPLogInfo(@"\nSmaato has successfully loaded a new ad.");
            [weakSelf.delegate bannerCustomEvent:weakSelf didLoadAd:weakSelf.adBannerView];
        }
    }];
}

#pragma mark - Smaato SOMABannerViewDelegate methods

- (void)landingPageWillBeDisplayed
{
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)landingPageHasBeenClosed
{
    [self.delegate bannerCustomEventDidFinishAction:self];
}

@end
