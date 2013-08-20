//
//  MPVungleInterstitialAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/21/13.
//
//

#import "MPLogging.h"
#import "MPVungleInterstitialAdapter.h"


@implementation MPVungleInterstitialAdapter

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)dealloc
{
    [VGVunglePub setDelegate:nil];
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    [VGVunglePub setDelegate:self];
    MPLogInfo(@"Requesting interstitial...\n,%@", info);
    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    if ([VGVunglePub adIsAvailable]) {
        [VGVunglePub playModalAd:rootViewController animated:TRUE];
    } else {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
        [self.delegate interstitialCustomEventDidExpire:self];
    }
}

#pragma mark - VGVunglePubDelegate methods

-(void)vungleMoviePlayed:(VGPlayData*)playData
{}

-(void)vungleStatusUpdate:(VGStatusData*)statusData
{}

-(void)vungleViewDidDisappear:(UIViewController*)viewController
{
    [self.delegate interstitialCustomEventDidDisappear:self];
    [VGVunglePub setDelegate:nil];
}

-(void)vungleViewWillAppear:(UIViewController*)viewController
{
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
}

-(void)vungleAppStoreViewDidDisappear
{}

@end
