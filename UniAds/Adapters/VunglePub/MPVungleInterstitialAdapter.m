//
//  MPVungleInterstitialAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/21/13.
//
//

#import "MPLogging.h"
#import "MPVungleInterstitialAdapter.h"

@interface MPVungleInterstitialAdapter ()
@property (nonatomic, assign) BOOL respondedToStatusEvent;
@end

@implementation MPVungleInterstitialAdapter

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)dealloc
{
    if ([VGVunglePub delegate] == self) {
        [VGVunglePub setDelegate:nil];
    }
}

#pragma mark - private

- (void)startingVunglePubWithAdapterData:(VunglePubAdapterData*)adapterData
{
    self.respondedToStatusEvent = NO;
    [VGVunglePub setDelegate:self];
    if (![VGVunglePub running]) {
        [VGVunglePub startWithPubAppID:adapterData.appId userData:adapterData.vgUserData];
    } else {
        [self.delegate interstitialCustomEvent:self didLoadAd:nil];
    }
}

#pragma mark - super

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting interstitial...\n,%@", info);
    VunglePubAdapterData* params = [VunglePubAdapterData dataWithInfo:info];
    params.vgUserData.locationEnabled = (nil != [self.delegate location]);
    [self startingVunglePubWithAdapterData:params];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    if ([VGVunglePub adIsAvailable]) {
        [VGVunglePub playModalAd:rootViewController animated:TRUE];
    } else {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

#pragma mark - VGVunglePubDelegate methods

-(void)vungleMoviePlayed:(VGPlayData*)playData
{}

-(void)vungleStatusUpdate:(VGStatusData*)statusData
{
    // this is a continuous polling update from Vungle, we only want to notify our delegate once per ad "request"
    if (!self.respondedToStatusEvent) {
        if(statusData.status == VGStatusOkay) {
            if([VGVunglePub adIsAvailable]) {
                self.respondedToStatusEvent = YES;
                [self.delegate interstitialCustomEvent:self didLoadAd:nil];
            }
        } else {
            self.respondedToStatusEvent = YES;
            [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
        }
    }
}

-(void)vungleViewDidDisappear:(UIViewController*)viewController
{
    [self.delegate interstitialCustomEventWillDisappear:self];
    [self.delegate interstitialCustomEventDidDisappear:self];
}

-(void)vungleViewWillAppear:(UIViewController*)viewController
{
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
}

-(void)vungleAppStoreViewDidDisappear
{}

@end
