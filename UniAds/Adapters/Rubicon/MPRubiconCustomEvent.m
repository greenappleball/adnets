//
//  MPRubiconCustomEvent.m
//  LifelikeClassifieds
//
//  Created by Dmitri Petrishin on 6/18/14.
//  Copyright (c) 2014 Postindustria. All rights reserved.
//

#import "MPRubiconCustomEvent.h"
#import <MBSAdRequest.h>
#import <MBSAdView.h>
#import "MPLogging.h"
#import "RubiconAdapterData.h"

@interface MPRubiconCustomEvent () <MBSAdDelegate>

@property (strong, nonatomic) MBSAdView *adView;
@property (strong, nonatomic) RubiconAdapterData* params;

@end

@implementation MPRubiconCustomEvent

- (void)dealloc
{
    self.adView.delegate = nil;
    _adView = nil;
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = [RubiconAdapterData dataWithInfo:info];
    // Test mode
    //self.params.isTestMode = @"test";
    [self loadAds];
}

#pragma	mark - Loading

-(void) loadAds
{
    self.adView = [MBSAdView createAdWithDelegate:self];

    //Request parameter configuration
    MBSAdRequest *adRequest = [[MBSAdRequest alloc]
                               initRequestWithServer:self.params.adServer
                               andAppId:self.params.appId
                               andPubId:self.params.pubId
                               ];

    if (self.delegate.location) {
        adRequest.locationLatitude = self.delegate.location.coordinate.latitude;
        adRequest.locationLongitude = self.delegate.location.coordinate.longitude;
    }

    adRequest.rfmAdType = RFM_ADTYPE_BANNER;

    //This optional parameter specifies the mode in which requests are
    //handled. The current supported values are as follows –
    //“test” – Test Mode, impressions are not counted
    adRequest.rfmAdMode = self.params.isTestMode;

    //Optional targeting info for ad request
    //    MBS_TARGETING_INFO_KEY_NBA_AGE      User’s Age, specified in years                  String Optional
    //    MBS_TARGETING_INFO_KEY_NBA_GENDER   User’s gender, values will be “M” or “F”        String Optional
    //    MBS_TARGETING_INFO_KEY_NBA_ZIP      User’s 5-digit ZIP code                         String Optional
    //    MBS_TARGETING_INFO_KEY_NBA_DMA      Designated marketing area                       String Optional
    //    MBS_TARGETING_INFO_KEY_NBA_INCOME   Specifies user income as a single value or      String Optional
    //                                        a range in US dollar, e.g. 50000, 50000-100000
    adRequest.targetingInfo = @{};

    // Request a new ad from MBSAd
    [self.adView requestFreshAdWithRequestParams:adRequest];
}

#pragma	mark - MBSAdDelegate

-(UIViewController *)currentViewControllerForMBSAd:(MBSAdView *)mbsAdView
{
    return [self.delegate viewControllerForPresentingModalView];
}

- (void)didRequestAd:(MBSAdView *)adView withUrl:(NSString *)requestUrlString
{
}

- (void)didReceiveAd:(MBSAdView *)adView
{
    MPLogInfo(@"Rubicon has successfully loaded a new ad.");
    [self.delegate bannerCustomEvent:self didLoadAd:self.adView];
}

- (void)didFailToReceiveAd:(MBSAdView *)adView
{
    MPLogInfo(@"Rubicon failed in trying to load or refresh an ad.");
    NSError* error = [NSError errorWithDomain:@"com.mopub.Rubicon_iOS_SDK" code:500 userInfo:@{@"userInfo" : @"Invalid Ad"}];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

// sent when ad is displayed
- (void)didDisplayAd:(MBSAdView *)adView
{}

// sent when ad fails to display
- (void)didFailToDisplayAd:(MBSAdView *)adView
{}

- (void)willPresentFullScreenModalFromAd:(MBSAdView *)adView
{
    [self.delegate bannerCustomEventWillBeginAction:self];
}

// Sent just after presenting a full ad landing view, in response to clicking
// on an ad
- (void)didPresentFullScreenModalFromAd:(MBSAdView *)adView
{}

// Sent just before dismissing the full ad landing view, in response to clicking
// of close/done button on the landing view
- (void)willDismissFullScreenModalFromAd:(MBSAdView *)adView
{}

// Sent just after dismissing a full screen view. Use this opportunity to
// restart anything you may have stopped as part of -willPresentFullScreenModalFromAd:.
- (void)didDismissFullScreenModalFromAd:(MBSAdView *)adView
{
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)adViewDidStopLoadingAndEnteredBackground:(MBSAdView *)adView
{
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

@end
