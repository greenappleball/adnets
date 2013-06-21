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
    [VGVunglePub playModalAd:rootViewController animated:TRUE];
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
}

-(void)vungleAppStoreViewDidDisappear
{}

@end
