//
//  InMobiInterstitialCustomEvent.m
//  MoPub
//
//  Copyright (c) 2012 MoPub, Inc. All rights reserved.
//

#import "MPInMobiInterstitialCustomEvent.h"
#import "MPInstanceProvider.h"
#import "InMobiAdapterData.h"

@interface MPInstanceProvider (InMobiInterstitials)

- (IMInterstitial *)buildIMInterstitialWithDelegate:(id<IMInterstitialDelegate>)delegate appId:(NSString *)appId;

@end

@implementation MPInstanceProvider (InMobiInterstitials)

- (IMInterstitial *)buildIMInterstitialWithDelegate:(id<IMInterstitialDelegate>)delegate appId:(NSString *)appId {
    IMInterstitial *inMobiInterstitial = [[IMInterstitial alloc] initWithAppId:appId];
    inMobiInterstitial.delegate = delegate;
    return inMobiInterstitial;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////


@interface MPInMobiInterstitialCustomEvent ()

@property (strong, nonatomic) IMInterstitial *inMobiInterstitial;

@end

@implementation MPInMobiInterstitialCustomEvent

@synthesize inMobiInterstitial = _inMobiInterstitial;

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting InMobi interstitial");
    InMobiAdapterData* mopubInfo = [InMobiAdapterData dataWithInfo:info];

    // intialize InMobi SDK
    [InMobi initialize:mopubInfo.appId];

    self.inMobiInterstitial = [[MPInstanceProvider sharedProvider] buildIMInterstitialWithDelegate:self appId:mopubInfo.appId];
    
    if (self.delegate.location) {
        [InMobi setLocationWithLatitude:self.delegate.location.coordinate.latitude
                               longitude:self.delegate.location.coordinate.longitude
                                accuracy:self.delegate.location.horizontalAccuracy];
    }
    self.inMobiInterstitial.additionaParameters = mopubInfo.inmobiExtras;
    [self.inMobiInterstitial loadInterstitial];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    [self.inMobiInterstitial presentInterstitialAnimated:YES];
}

#pragma mark - IMAdInterstitialDelegate


- (void)interstitialDidReceiveAd:(IMInterstitial *)ad {
    MPLogInfo(@"InMobi interstitial did load");
    [self.delegate interstitialCustomEvent:self didLoadAd:ad];
}

- (void)interstitial:(IMInterstitial *)ad didFailToReceiveAdWithError:(IMError *)error {

    MPLogInfo(@"InMobi banner did fail with error: %@", error.localizedDescription);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)interstitialWillPresentScreen:(IMInterstitial *)ad {
    MPLogInfo(@"InMobi interstitial will present");
    [self.delegate interstitialCustomEventWillAppear:self];

    // InMobi doesn't seem to have a separate callback for the "did appear" event, so we
    // signal that manually.
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void)interstitial:(IMInterstitial *)ad didFailToPresentScreenWithError:(IMError *)error {
    MPLogInfo(@"InMobi interstitial failed to present with error: %@", error.localizedDescription);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)interstitialWillDismissScreen:(IMInterstitial *)ad {
    MPLogInfo(@"InMobi interstitial will dismiss");
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)interstitialDidDismissScreen:(IMInterstitial *)ad {
    MPLogInfo(@"InMobi interstitial did dismiss");
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)interstitialWillLeaveApplication:(IMInterstitial *)ad {
    MPLogInfo(@"InMobi interstitial will leave application");
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void) interstitialDidInteract:(IMInterstitial *)ad withParams:(NSDictionary *)dictionary {
    MPLogInfo(@"InMobi interstitial was tapped");
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

@end
