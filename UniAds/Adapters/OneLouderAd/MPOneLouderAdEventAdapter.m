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

//- (NSError*) errorWithCode:(NSInteger)code userInfo:(NSDictionary*)info {
//    NSDictionary* userInfo = [info isKindOfClass:[NSDictionary class]] ? info : [NSDictionary dictionary];
//    return [NSError errorWithDomain:AD_DOMAIN code:code userInfo:userInfo];
//}

- (void)releaseBannerViewDelegateSafely {
    [_adBannerView setDelegate:nil];
    _adBannerView = nil;
}

#pragma	mark -

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = info;
    [OLAdManager startWithApplicationId:@"adlibsdkdemo"];
    [self loadAdsWithParams:self.params];
}

#pragma	mark - MDotM

-(void) loadAdsWithParams:(NSDictionary*)params
{
    BOOL isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    CGRect adRect = isIphone ? BANNER_RECT : BANNER_LONG_RECT;
    OLAdType adType = isIphone ? OLAdTypeBanner :OLAdTypeLongBanner;

    _adBannerView = [[OLAdView alloc] initWithFrame:adRect adPlacement:@"global" withAdType:adType];
    _adBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _adBannerView.backgroundColor = [UIColor clearColor];
    _adBannerView.delegate = self;

    [_adBannerView setupViewsAndReloadAd:NO];
}

-(UIViewController*)adTopViewController {
    return [self.delegate viewControllerForPresentingModalView];
}

#pragma	mark -  OLAdViewDelegate

// Callbacks to let the app know that the full screen web view has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the web view is being viewed (i.e. for a game).  You might also want to get a new ad when the full screen closes.
- (void) fullScreenWebViewActivated
{}
- (void) fullScreenWebViewClosed
{}

// Callbacks to let the app know that an ad has just expanded or collapsed.  This means that an ad is taking up part of the screen but interaction with various elements of the app may still be possible.
// If it has expanded then the ad is currently currently displaying over some of the content.  The app should keep track of this and call collapseAd if the user interacts with the app instead of the ad.
- (void) adDidExpand
{}
- (void) adDidCollapse
{}

// Callback to let app know that a special banner has been clicked.  This method is provided to help track if an ad click is respondible for sending the user out of the app.
// Either this method, fullScreenWebViewActivated, adDidExpand  should be called on ad click where supported.
// Examples click actions that would trigger this are click to call, click to app, click to itunes, etc.
// If the app is going to exit or go to the background the the normal UIApplicationDelegate methods will still get called after this.
// NOTE: Some ad network SDKs don't provide a tracking option for ads that don't open a full screen view so our SDK can't provide this additional information in those cases.
- (void) adViewWasClicked
{
    [self.delegate trackClick];
}

- (void)olAdView:(OLAdView *)olAdView adHiddenChanged:(BOOL)hidden
{
//	[UIView animateWithDuration:0.25
//						  delay:0
//						options:UIViewAnimationCurveEaseOut
//					 animations:^{
//						 CGRect frame = self.view.bounds;
//						 if (!hidden) frame.size.height -= _olAdView.frame.size.height;
//						 _contentView.frame = frame;
//                         _olAdView.frame = CGRectMake(CGRectGetMinX(_olAdView.frame),
//                                                      CGRectGetMaxY(_contentView.frame),
//                                                      CGRectGetWidth(_olAdView.frame),
//                                                      CGRectGetHeight(_olAdView.frame));
//					 }
//					 completion:nil];
    if (hidden) {
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    } else {
        [self.delegate bannerCustomEvent:self didLoadAd:_adBannerView];
    }
}

- (void)olAdView:(OLAdView *)olAdView adLoaded:(BOOL)loaded {
    if (loaded) {
        MPLogInfo(@"OneLouderAd has successfully loaded a new ad.");
    } else {
        MPLogInfo(@"OneLouderAd failed in trying to load or refresh an ad.");
    }
    [self olAdView:olAdView adHiddenChanged:!loaded];
}

// Space delimited keywords (ex: MOVIE CATS FUNNY)
- (NSString*)adKeywords
{
    return @"";
}

@end
