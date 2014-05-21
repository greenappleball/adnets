//
//  MPFlurryAdsInterstitialAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/19/13.
//
//

#import "MPLogging.h"
#import "FlurryAdapterData.h"
#import "MPFlurryAdsInterstitialAdapter.h"

@interface MPFlurryAdsInterstitialAdapter ()
@property (strong, nonatomic) FlurryAdapterData* mopubInfo;
@end

@implementation MPFlurryAdsInterstitialAdapter

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)dealloc
{
    [[FlurryAdsWrapper sharedInstance] removeDelegate:self];
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting FlurryAds interstitial...\n,%@", info);
    self.mopubInfo = [FlurryAdapterData dataWithInfo:info];
    [FlurryAdsWrapper fetchAdForSpace:[self.mopubInfo adSpaceName] size:FULLSCREEN withDelegate:self];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    NSString* adSpace = [self.mopubInfo adSpaceName];
    if ([FlurryAdsWrapper adReadyForSpace:adSpace]) {
        [FlurryAdsWrapper displayAdSpace:adSpace inView:rootViewController.view];
        [self.delegate interstitialCustomEventDidAppear:self];
    } else {
        MPLogInfo(@"Requesting FlurryAds (%@) interstitial...", adSpace);
        [FlurryAdsWrapper fetchAdForSpace:adSpace size:FULLSCREEN withDelegate:self];
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
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    MPLogInfo(@"FlurryAds (%@) interstitial was dismissed", adSpace);
    [self.delegate interstitialCustomEventDidDisappear:self];
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
