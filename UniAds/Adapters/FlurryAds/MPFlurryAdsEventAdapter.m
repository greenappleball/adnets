//
//  MPFlurryAdsEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/19/13.
//
//

#import "MPLogging.h"
#import "FlurryAdapterData.h"
#import "MPFlurryAdsEventAdapter.h"

@interface MPFlurryAdsEventAdapter ()
@property (strong, nonatomic) UIView* adBannerView;
@property (strong, nonatomic) FlurryAdapterData* mopubInfo;
@end

@implementation MPFlurryAdsEventAdapter

- (void)dealloc
{
    [[FlurryAdsWrapper sharedInstance] removeDelegate:self];
}

- (UIView *)adBannerView
{
    if (!_adBannerView) {
        _adBannerView = [FlurryAdsWrapper sharedAdView];
    }
    return _adBannerView;
}

#pragma mark - MPBannerCustomEvent Subclass Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting FlurryAds banner...");
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = SIZE_VIEW;
    }
    self.adBannerView.frame = (CGRect){CGPointZero, size};
    self.adBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mopubInfo = [FlurryAdapterData dataWithInfo:info];

    [FlurryAdsWrapper fetchAndDisplayAdForSpace:[self.mopubInfo adSpaceName] size:BANNER_TOP inView:self.adBannerView withDelegate:self];
}

#pragma mark - FlurryAdDelegate methods

- (void) spaceDidReceiveAd:(NSString*)adSpace{
    MPLogInfo(@"Successfully loaded banner FlurryAds: %@", adSpace);
    [self.delegate bannerCustomEvent:self didLoadAd:self.adBannerView];
}

- (void) spaceDidFailToReceiveAd:(NSString*)adSpace error:(NSError *)error {
    MPLogInfo(@"Failed to load banner FlurryAds: %@\n%@", adSpace, error.userInfo);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    MPLogInfo(@"FlurryAds (%@) banner was dismissed", adSpace);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)spaceWillLeaveApplication:(NSString *)adSpace
{
    MPLogInfo(@"FlurryAds (%@) banner will leave application", adSpace);
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

@end
