//
//  MPOneLouderAdEventAdapter.m
//  Pods
//
//  Created by Dmitri Petrishin on 8/22/13.
//
//

#import "OLAdView.h"
#import "OLAdManager.h"
#import "OLAdAdapterData.h"
#import "MPOneLouderAdEventAdapter.h"
#import "MPLogging.h"

@interface MPOneLouderAdEventAdapter () <OLAdViewDelegate>

@property(strong, nonatomic) OLAdView* adBannerView;
@property(strong, nonatomic) OLAdAdapterData* params;

@end


#pragma mark - Implementation

@implementation MPOneLouderAdEventAdapter

- (void)dealloc {
    [self releaseBannerViewDelegateSafely];
}

#pragma	mark - Private

- (void)releaseBannerViewDelegateSafely {
    [self.adBannerView stop];
    [self.adBannerView setDelegate:nil];
    self.adBannerView = nil;
}

- (void)postloadingWithOladView:(OLAdView*)oladView
{
    [oladView stop];
    oladView.btnClose.hidden = [self isCloseBtnHidden];
}

#pragma	mark -

- (NSString*)appId
{
    return [self.params appId];
}

- (NSString*)adPlacement
{
    return [self.params adPlacement];
}

- (BOOL)isCloseBtnHidden
{
    return [self.params isCloseButtonHide];
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = [OLAdAdapterData dataWithInfo:info];
    [self loadAds];
}

#pragma	mark - Loading

-(void) loadAds
{
    // Warning: for using OLAd SDK it needs starting it in AppDelegate
    // [OLAdManager startWithApplicationId:@"appid"];
    [OLAdManager sharedInstance].location = [self.delegate location];

    BOOL isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    OLAdType adType = isIphone ? OLAdTypeBanner :OLAdTypeLongBanner;
    CGRect adRect = isIphone ? BANNER_RECT : BANNER_LONG_RECT;

    self.adBannerView = [[OLAdView alloc] initWithFrame:adRect adPlacement:[self adPlacement] withAdType:adType];
    self.adBannerView.backgroundColor = [UIColor clearColor];
    self.adBannerView.delegate = self;

    [self.adBannerView startAndRequestAd];
}

#pragma	mark - OLAdViewDelegate

// Returns the view controller that will be responsible for displaying modal views.
// This is mostly used when the SDK needs to takeover full screen (such as when an ad is clicked).
// NOTE: As of iOS 6 the app now controls which orientations can be used by ads/in-app browser in either the Info.plist or in the AppDelegate application:supportedInterfaceOrientationsForWindow: method.
// We recommend for maximum compatibility with RichMedia ads that your app enables all orientations and then programatically restricts orientations where necessary using the UIViewController supportedInterfaceOrientations method.
- (UIViewController *) adTopViewController
{
    return [self.delegate viewControllerForPresentingModalView];
}

- (NSDictionary *) adTargetingParameters
{
    return nil;
}

// Callbacks to let the app know that the full screen web view has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the web view is being viewed (i.e. for a game).  You might also want to get a new ad when the full screen closes.
- (void) olAdViewfullScreenWebViewActivated:(OLAdView *)olAdView
{
}

- (void) olAdViewfullScreenWebViewClosed:(OLAdView *)olAdView
{
}

// Callbacks to let the app know that an ad has just expanded or collapsed.  This means that an ad is taking up part of the screen but interaction with various elements of the app may still be possible.
// If it has expanded then the ad is currently currently displaying over some of the content.  The app should keep track of this and call collapseAd if the user interacts with the app instead of the ad.
- (void) olAdViewAdDidExpand:(OLAdView *)olAdView
{
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void) olAdViewAdDidCollapse:(OLAdView *)olAdView
{
    [self.delegate bannerCustomEventDidFinishAction:self];
}

// Callback to let app know that a special banner has been clicked.  This method is provided to help track if an ad click is respondible for sending the user out of the app.
// Either this method, fullScreenWebViewActivated, adDidExpand  should be called on ad click where supported.
// Examples click actions that would trigger this are click to call, click to app, click to itunes, etc.
// If the app is going to exit or go to the background the the normal UIApplicationDelegate methods will still get called after this.
// NOTE: Some ad network SDKs don't provide a tracking option for ads that don't open a full screen view so our SDK can't provide this additional information in those cases.
- (void) olAdViewWasClicked:(OLAdView *)olAdView
{
}

// Callback to track success / fail of the add
- (void) olAdViewAdSucceeded:(OLAdView *)olAdView
{
    MPLogInfo(@"OneLouderAd has successfully loaded a new ad.");
    [self postloadingWithOladView:olAdView];
    [self.delegate bannerCustomEvent:self didLoadAd:self.adBannerView];
}

- (void) olAdViewAdFailed:(OLAdView *)olAdView
{
    MPLogInfo(@"OneLouderAd failed in trying to load or refresh an ad.");
    [self postloadingWithOladView:olAdView];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void) olAdViewAdClosed:(OLAdView *)olAdView
{
}

- (void) olAdView:(OLAdView*)olAdView adLoaded:(BOOL)loaded
{
    [self postloadingWithOladView:olAdView];
    if (loaded) {
        MPLogInfo(@"OneLouderAd has successfully loaded a new ad.");
        [self.delegate bannerCustomEvent:self didLoadAd:self.adBannerView];
    } else {
        MPLogInfo(@"OneLouderAd failed in trying to load or refresh an ad.");
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

// Space delimited keywords (ex: MOVIE CATS FUNNY)
- (NSString*) adKeywords
{
    return @"";
}

@end
