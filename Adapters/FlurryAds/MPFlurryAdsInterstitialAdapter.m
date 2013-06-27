//
//  MPFlurryAdsInterstitialAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/19/13.
//
//

#import "FlurryAds.h"
#import "MPLogging.h"
#import "MPFlurryAdsInterstitialAdapter.h"

#define kAdSpaceName   @"adSpaceName"


@interface MPFlurryAdsInterstitialAdapter ()

@property (strong, nonatomic) NSDictionary* mopubInfo;
@property (readonly, nonatomic) NSString* adSpaceName;

@end


@implementation MPFlurryAdsInterstitialAdapter

#pragma mark - Assignings

- (NSString *)adSpaceName
{
    return self.mopubInfo[kAdSpaceName]?:@"Strongly need to define adSpaceName!!!";
}

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting FlurryAds interstitial...\n,%@", info);
    self.mopubInfo = info;
    [FlurryAds setAdDelegate:self];
    [FlurryAds fetchAdForSpace:self.adSpaceName frame:CGRectZero size:FULLSCREEN];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    if ([FlurryAds adReadyForSpace:self.adSpaceName]) {
        [FlurryAds displayAdForSpace:self.adSpaceName onView:rootViewController.view];
        [self.delegate interstitialCustomEventDidAppear:self];
    } else {
        MPLogInfo(@"Requesting FlurryAds (%@) interstitial...", self.adSpaceName);
        [FlurryAds fetchAdForSpace:self.adSpaceName frame:CGRectZero size:FULLSCREEN];
    }
}

#pragma mark - FlurryAdDelegate methods

- (void) spaceDidReceiveAd:(NSString*)adSpace{
    MPLogInfo(@"Successfully loaded interstitial FlurryAds: %@", adSpace);
    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
}

- (void) spaceDidFailToReceiveAd:(NSString*)adSpace error:(NSError *)error {
    MPLogInfo(@"Failed to load interstitial FlurryAds: %@\n%@", adSpace, error.userInfo);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    [FlurryAds setAdDelegate:nil];
}

- (BOOL) spaceShouldDisplay:(NSString*)adSpace interstitial:(BOOL)interstitial {
    return YES;
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    MPLogInfo(@"FlurryAds (%@) interstitial was dismissed", adSpace);
    [self.delegate interstitialCustomEventDidDisappear:self];
    [FlurryAds removeAdFromSpace:self.adSpaceName];
    [FlurryAds setAdDelegate:nil];
}

- (void)spaceWillLeaveApplication:(NSString *)adSpace
{
    MPLogInfo(@"FlurryAds (%@) interstitial will leave application", adSpace);
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void)spaceDidReceiveClick:(NSString *)adSpace
{
    MPLogInfo(@"FlurryAds (%@) interstitial did receive click", adSpace);
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

@end
