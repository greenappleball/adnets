//
//  MPOneLouderAdInterstitialAdapter.m
//  Pods
//
//  Created by Dmitri Petrishin on 8/22/13.
//
//

#import "MPLogging.h"
#import "OLAdAdapterData.h"
#import "OLInterstitialAd.h"
#import "MPOneLouderAdInterstitialAdapter.h"

@interface MPOneLouderAdInterstitialAdapter () <OLInterstitialAdDelegate>
@property(weak, nonatomic) UIViewController* rootViewController;
@property(strong, nonatomic) OLInterstitialAd* interstitialView;
@property(strong, nonatomic) OLAdAdapterData* params;
@end

@implementation MPOneLouderAdInterstitialAdapter

#pragma	mark - accessories

- (OLInterstitialAd *)interstitialView
{
    if (nil == _interstitialView) {
        _interstitialView = [OLInterstitialAd new];
    }
    return _interstitialView;
}

#pragma	mark - super

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    // Warning: for using OLAd SDK it needs starting it in AppDelegate otherwise may be crash (v3.0.3)
    // [OLAdManager startWithApplicationId:@"appid"];
    [OLAdManager sharedInstance].location = [self.delegate location];
    MPLogInfo(@"Requesting interstitial...\n,%@", info);
    self.params = [OLAdAdapterData dataWithInfo:info];

    if ([OLAdManager sharedInstance].advertisingIdentifierString) {
        self.interstitialView.delegate = self;
        [self.interstitialView requestAdWithPlacementName:self.params.adPlacement];
    } else {
        MPLogInfo(@"OLAd error interstitial ad retrieval: for using OLAd SDK it needs starting it in AppDelegate");
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    self.rootViewController = rootViewController;
    [self.interstitialView displayAdWithPlacementName:self.params.adPlacement];
}

#pragma mark - OLInterstitialAdDelegate

// Callbacks to let the app know that the full screen web view has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the web view is being viewed (i.e. for a game).  You might also want to get a new ad when the full screen closes.
- (void) olInterstitialAdFullScreenWebViewActivated:(OLInterstitialAd*)olInterstitialAd
{}

- (void) olInterstitialAdFullScreenWebViewClosed:(OLInterstitialAd*)olInterstitialAd
{}

// Callbacks to let the app know that an ad has just expanded or collapsed.  This means that an ad is taking up part of the screen but interaction with various elements of the app may still be possible.
// If it has expanded then the ad is currently currently displaying over some of the content.  The app should keep track of this and call collapseAd if the user interacts with the app instead of the ad.
- (void) olInterstitialAdDidExpand:(OLInterstitialAd*)olInterstitialAd
{}

- (void) olInterstitialAdDidCollapse:(OLInterstitialAd*)olInterstitialAd
{}

// Callbacks to let the app know that a full screen interstitial has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the interstitial is being viewed and restart after it is closed.
// These are optional since olInterstitialAdFullScreenWebViewActivated and olInterstitialAdFullScreenWebViewClosed will be called as well in case only those are implemented.
- (void) olInterstitialAdInterstitialActivated:(OLInterstitialAd*)olInterstitialAd
{
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void) olInterstitialAdInterstitialClosed:(OLInterstitialAd*)olInterstitialAd
{
    [self.delegate interstitialCustomEventDidDisappear:self];
}

// Callback to let app know that a special banner has been clicked.  This method is provided to help track if an ad click is respondible for sending the user out of the app.
// Either this method, olInterstitialAdFullScreenWebViewActivated should be called on ad click where supported.
// Examples click actions that would trigger this are click to call, click to app, click to itunes, etc.
// If the app is going to exit or go to the background the the normal UIApplicationDelegate methods will still get called after this.
// NOTE: Some ad network SDKs don't provide a tracking option for ads that don't open a full screen view so our SDK can't provide this additional information in those cases.
- (void) olInterstitialAdWasClicked:(OLInterstitialAd*)olInterstitialAd
{
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

// Callbacks that let you know the status of a call to requestInterstitialAd.  These will be called once the ad has either been loaded successfully (succeeded) or is not available (failed).
// As a saftey precaution there is a timer setup that guarantees that these will be called within 10 seconds in case something went wrong and the application is waiting for a response.
- (void) olInterstitialAdSucceeded:(OLInterstitialAd*)olInterstitialAd
{
    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
}

- (void) olInterstitialAdFailed:(OLInterstitialAd*)olInterstitialAd
{
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey: @"OneLouder interstitial loading failed by unknown reason"};
    NSError* error = [NSError errorWithDomain:AD_DOMAIN code:1000 userInfo:userInfo];
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

// Space delimited keywords (ex: MOVIE CATS FUNNY)
- (NSString *)adKeywords
{
    return @"";
}

- (NSDictionary *)adTargetingParameters
{
    return nil;
}

// Returns the view controller that will be responsible for displaying modal views.
// This is mostly used when the SDK needs to takeover full screen (such as when an ad is clicked).
// NOTE: As of iOS 6 the app now controls which orientations can be used by ads/in-app browser in either the Info.plist or in the AppDelegate application:supportedInterfaceOrientationsForWindow: method.
// We recommend for maximum compatibility with RichMedia ads that your app enables all orientations and then programatically restricts orientations where necessary using the UIViewController supportedInterfaceOrientations method.
- (UIViewController *)adTopViewController
{
    return self.rootViewController;
}

@end
