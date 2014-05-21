//
//  MPAppSponsorInterstitialAdapter.m
//  Pods
//
//  Created by Dmitri Petrishin on 11/5/13.
//
//

#import "AppSponsorAdapterData.h"
#import "MPAppSponsorInterstitialAdapter.h"

@interface MPAppSponsorInterstitialAdapter () <ASPopupAdDelegate>
@property(strong, nonatomic) ASPopupAd * controller;
@end

@implementation MPAppSponsorInterstitialAdapter

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting AppSponsor interstitial...");
    AppSponsorAdapterData* mopubInfo = [AppSponsorAdapterData dataWithInfo:info];
    ASPopupAd* adController = [ASPopupAd alloc];
    if ([self.delegate location]) {
        adController = [adController enableLocationSupport];
    }
    self.controller = [adController initWithZoneId:mopubInfo.zoneId];
    self.controller.testMode = mopubInfo.isTesting;
    self.controller.delegate = self;
    [self.controller load];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    self.controller.parentController = rootViewController;
    [self.controller presentAd];
}

#pragma mark - ASPopupAdDelegate

-(void)popoverWillAppear
{
    MPLogInfo(@"AppSponsor interstitial was displayed");
    [self.delegate interstitialCustomEventWillAppear: self];
    [self.delegate interstitialCustomEventDidAppear: self];
}

-(void)popoverWillDisappear:(NSString *)reason
{
    MPLogInfo(@"AppSponsor interstitial was dismissed");
    [self.delegate interstitialCustomEventWillDisappear: self];
    [self.delegate interstitialCustomEventDidDisappear:self];
}

-(void)didCacheInterstitial
{
    MPLogInfo(@"AppSponsor has successfully loaded a new interstitial ad.");
    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
}
-(void)didCloseInterstitial
{
}
-(void)didClickInterstitial
{
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}
-(void)popoverDidFailToLoadWithError:(NSError*)error
{
    MPLogInfo(@"Failed to load AppSponsor interstitial: %@", [error localizedDescription]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

@end
