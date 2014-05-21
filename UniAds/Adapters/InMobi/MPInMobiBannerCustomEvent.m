//
//  InMobiBannerCustomEvent.m
//  MoPub
//
//  Copyright (c) 2012 MoPub, Inc. All rights reserved.
//

#import "MPInMobiBannerCustomEvent.h"
#import "MPInstanceProvider.h"
#import "InMobiAdapterData.h"

@interface MPInstanceProvider (InMobiBanners)

- (IMBanner *)buildIMBannerWithFrame:(CGRect)frame appId:(NSString *)appId adSize:(int)adSize;

@end

@implementation MPInstanceProvider (InMobiBanners)

- (IMBanner *)buildIMBannerWithFrame:(CGRect)frame appId:(NSString *)appId adSize:(int)adSize
{
    return [[IMBanner alloc] initWithFrame:frame appId:appId adSize:adSize];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPInMobiBannerCustomEvent ()

@property (strong, nonatomic) IMBanner *inMobiBanner;

@end

@implementation MPInMobiBannerCustomEvent

#pragma mark - MPBannerCustomEvent Subclass Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting InMobi banner");
    InMobiAdapterData* mopubInfo = [InMobiAdapterData dataWithInfo:info];

    // intialize InMobi SDK
    [InMobi initialize:mopubInfo.appId];
    
    BOOL isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    int imAdSizeConstant = isIphone ? IM_UNIT_320x50 : IM_UNIT_728x90;

    self.inMobiBanner = [[MPInstanceProvider sharedProvider] buildIMBannerWithFrame:CGRectMake(0, 0, size.width, size.height) appId:mopubInfo.appId adSize:imAdSizeConstant];
    self.inMobiBanner.refreshInterval = REFRESH_INTERVAL_OFF;
    self.inMobiBanner.delegate = self;

    if (self.delegate.location) {
        [InMobi setLocationWithLatitude:self.delegate.location.coordinate.latitude
                               longitude:self.delegate.location.coordinate.longitude
                                accuracy:self.delegate.location.horizontalAccuracy];
    }
    self.inMobiBanner.additionaParameters = mopubInfo.inmobiExtras;
    [self.inMobiBanner loadBanner];

}

- (BOOL)enableAutomaticImpressionAndClickTracking
{
    // Override this method to return NO to perform impression and click tracking manually.

    return NO;
}

#pragma mark - IMAdDelegate

#pragma mark InMobiAdDelegate methods

- (void)bannerDidReceiveAd:(IMBanner *)banner {
    MPLogInfo(@"InMobi banner did load");
    [self.delegate trackImpression];
    [self.delegate bannerCustomEvent:self didLoadAd:banner];
}

- (void)banner:(IMBanner *)banner didFailToReceiveAdWithError:(IMError *)error {
    MPLogInfo(@"InMobi banner did fail with error: %@", error.localizedDescription);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)bannerDidDismissScreen:(IMBanner *)banner {
    MPLogInfo(@"adViewDidDismissScreen");
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)bannerWillDismissScreen:(IMBanner *)banner {
    MPLogInfo(@"adViewWillDismissScreen");
}

- (void)bannerWillPresentScreen:(IMBanner *)banner {
    MPLogInfo(@"InMobi banner will present modal");
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)bannerWillLeaveApplication:(IMBanner *)banner {
    MPLogInfo(@"InMobi banner will leave application");
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

- (void)bannerDidInteract:(IMBanner *)banner withParams:(NSDictionary *)dictionary {
    MPLogInfo(@"InMobi banner was clicked");
    [self.delegate trackClick];
}

@end
