//
//  MPOneLouderAdEventAdapter.m
//  Pods
//
//  Created by Dmitri Petrishin on 8/22/13.
//
//

#import "OLAdView.h"
#import "OLAdManager.h"
#import "MPOneLouderAdEventAdapter.h"
#import "MPLogging.h"

#define kAppID                  @"appId"
#define kAdPlacement            @"adPlacement"
#define kCloseButton            @"closeButton"
#define     vHide                   @"hide"


@interface MPOneLouderAdEventAdapter () <OLAdViewDelegate> {
    OLAdView* _adBannerView;
}

@property(retain, nonatomic) NSDictionary* params;


@end


#pragma mark - Implementation

@implementation MPOneLouderAdEventAdapter

- (void)dealloc {
    [self releaseBannerViewDelegateSafely];
}

#pragma	mark - Private

- (void)releaseBannerViewDelegateSafely {
    [_adBannerView setDelegate:nil];
    _adBannerView = nil;
}

#pragma	mark -

- (NSString*)appId
{
    return @"adlibsdkdemo";self.params[kAppID]?:@"craigslist";
}

- (NSString*)adPlacement
{
    return self.params[kAdPlacement]?:@"global";
}

- (BOOL)isCloseBtnHidden
{
    NSString* hideValue = self.params[kCloseButton];
    BOOL isCloseBtnHidden = hideValue?[vHide isEqualToString:[hideValue lowercaseString]]:NO;
    return isCloseBtnHidden;
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = info;
    [self loadAds];
}

#pragma	mark - Loading

-(void) loadAds
{
    [OLAdManager startWithApplicationId:[self appId]];

    BOOL isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    OLAdType adType = isIphone ? OLAdTypeBanner :OLAdTypeLongBanner;
    CGRect adRect = isIphone ? BANNER_RECT : BANNER_LONG_RECT;

    _adBannerView = [[OLAdView alloc] initWithFrame:adRect adPlacement:[self adPlacement] withAdType:adType];
    _adBannerView.backgroundColor = [UIColor clearColor];
    _adBannerView.delegate = self;

    [_adBannerView setupViewsAndReloadAd:NO];
}

-(UIViewController*)adTopViewController {
    return [self.delegate viewControllerForPresentingModalView];
}

#pragma	mark - OLAdViewDelegate

// Callbacks to let the app know that an ad has just expanded or collapsed.  This means that an ad is taking up part of the screen but interaction with various elements of the app may still be possible.
// If it has expanded then the ad is currently currently displaying over some of the content.  The app should keep track of this and call collapseAd if the user interacts with the app instead of the ad.
- (void) adDidExpand
{
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void) adDidCollapse
{
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)olAdView:(OLAdView *)olAdView adHiddenChanged:(BOOL)hidden
{
    if (hidden) {
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    } else {
        [self.delegate bannerCustomEvent:self didLoadAd:_adBannerView];
    }
}

- (void)olAdView:(OLAdView *)olAdView adLoaded:(BOOL)loaded {
    if (!loaded) {
        MPLogInfo(@"OneLouderAd failed in trying to load or refresh an ad.");
    } else {
        MPLogInfo(@"OneLouderAd has successfully loaded a new ad.");
    }
    olAdView.btnClose.hidden = [self isCloseBtnHidden];
    [self olAdView:olAdView adHiddenChanged:!loaded];
}

// Space delimited keywords (ex: MOVIE CATS FUNNY)
- (NSString*)adKeywords
{
    return @"";
}

@end
