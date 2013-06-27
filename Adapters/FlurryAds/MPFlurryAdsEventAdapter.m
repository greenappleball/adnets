//
//  MPFlurryAdsEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/19/13.
//
//

#import "FlurryAds.h"
#import "MPLogging.h"
#import "MPFlurryAdsEventAdapter.h"

#define kAdSpaceName   @"adSpaceName"


@interface MPFlurryAdsEventAdapter ()

@property (strong, nonatomic) UIView* adBannerView;
@property (strong, nonatomic) NSDictionary* mopubInfo;
@property (readonly, nonatomic) NSString* adSpaceName;

@end


@implementation MPFlurryAdsEventAdapter

- (void)dealloc
{
    [FlurryAds removeAdFromSpace:self.adSpaceName];
    self.adBannerView = nil;
}

#pragma mark - Assignings

- (NSString *)adSpaceName
{
    return self.mopubInfo[kAdSpaceName]?:@"Strongly need to define adSpaceName!!!";
}

#pragma mark - MPBannerCustomEvent Subclass Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting FlurryAds banner...");
    self.adBannerView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, size}];
    self.adBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mopubInfo = info;
    [FlurryAds setAdDelegate:self];
    [FlurryAds fetchAdForSpace:self.adSpaceName frame:self.adBannerView.frame size:BANNER_TOP];
}

#pragma mark - FlurryAdDelegate methods

- (void) spaceDidReceiveAd:(NSString*)adSpace{
    MPLogInfo(@"Successfully loaded banner FlurryAds: %@", adSpace);
    [FlurryAds displayAdForSpace:adSpace onView:self.adBannerView];
    [self.delegate bannerCustomEvent:self didLoadAd:self.adBannerView];
}

- (void) spaceDidFailToReceiveAd:(NSString*)adSpace error:(NSError *)error {
    MPLogInfo(@"Failed to load banner FlurryAds: %@\n%@", adSpace, error.userInfo);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    [FlurryAds setAdDelegate:nil];
}

- (BOOL) spaceShouldDisplay:(NSString*)adSpace interstitial:(BOOL)interstitial {
    return YES;
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    MPLogInfo(@"FlurryAds (%@) banner was dismissed", adSpace);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    [FlurryAds setAdDelegate:nil];
}

- (void)spaceWillLeaveApplication:(NSString *)adSpace
{
    MPLogInfo(@"FlurryAds (%@) banner will leave application", adSpace);
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

@end
