//
//  OLInterstitialManager.h
//  OLAdKitSDK
//
//  Created by Alex Volovoy on 11/28/12.
//  Copyright (c) 2012 OneLouder Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLAdManager.h"
 
@class OLInterstitialManager;

@protocol OLInterstitialManagerDelegate  <NSObject>
// Returns the view controller that will be responsible for displaying modal views.
// This is mostly used when the SDK needs to takeover full screen (such as when an ad is clicked).
// NOTE: As of iOS 6 the app now controls which orientations can be used by ads/in-app browser in either the Info.plist or in the AppDelegate application:supportedInterfaceOrientationsForWindow: method.
// We recommend for maximum compatibility with RichMedia ads that your app enables all orientations and then programatically restricts orientations where necessary using the UIViewController supportedInterfaceOrientations method.
@property (nonatomic,readonly) UIViewController *adTopViewController;

@optional
// Callbacks to let the app know that the full screen web view has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the web view is being viewed (i.e. for a game).  You might also want to get a new ad when the full screen closes.
- (void) olInterstitialManagerFullScreenWebViewActivated:(OLInterstitialManager *)olInterstitialManager;
- (void) olInterstitialManagerFullScreenWebViewClosed:(OLInterstitialManager *)olInterstitialManager;

// Callbacks to let the app know that an ad has just expanded or collapsed.  This means that an ad is taking up part of the screen but interaction with various elements of the app may still be possible.
// If it has expanded then the ad is currently currently displaying over some of the content.  The app should keep track of this and call collapseAd if the user interacts with the app instead of the ad.
- (void) olInterstitialManagerAdDidExpand:(OLInterstitialManager *)olInterstitialManager;
- (void) olInterstitialManagerAdDidCollapse:(OLInterstitialManager *)olInterstitialManager;

// Callbacks to let the app know that a full screen interstitial has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the interstitial is being viewed and restart after it is closed.
// These are optional since fullScreenWebViewActivated and fullScreenWebViewClosed will be called as well in case only those are implemented.
- (void) olInterstitialManagerInterstitialActivated:(OLInterstitialManager *)olInterstitialManager;
- (void) olInterstitialManagerInterstitialClosed:(OLInterstitialManager *)olInterstitialManager;

// Callback to let app know that a special banner has been clicked.  This method is provided to help track if an ad click is respondible for sending the user out of the app.
// Either this method, fullScreenWebViewActivated, adDidExpand  should be called on ad click where supported.
// Examples click actions that would trigger this are click to call, click to app, click to itunes, etc.
// If the app is going to exit or go to the background the the normal UIApplicationDelegate methods will still get called after this.
// NOTE: Some ad network SDKs don't provide a tracking option for ads that don't open a full screen view so our SDK can't provide this additional information in those cases.
- (void) olInterstitialManagerAdViewWasClicked:(OLInterstitialManager *)olInterstitialManager;

// Callbacks that let you know the status of a call to getInterstitialAd.  These will be called once the ad has either been loaded successfully (succeeded) or is not available (failed).
// As a saftey precaution there is a timer setup that guarantees that these will be called within 10 seconds in case something went wrong and the application is waiting for a response.
- (void) olInterstitialManagerGetAdSucceeded:(OLInterstitialManager *)olInterstitialManager;
- (void) olInterstitialManagerGetAdFailed:(OLInterstitialManager *)olInterstitialManager;

@end


@interface OLInterstitialManager : NSObject

@property (nonatomic, assign) id<OLInterstitialManagerDelegate> delegate;

+ (OLInterstitialManager *)sharedInstance;

-(void) displayScreenAd;
-(void) displayLaunchAd;
-(void) displayPreRollAd;

+(void) displayScreenAd;
+(void) displayLaunchAd;
+(void) displayPreRollAd;

-(void) displayAdWithPlacementName:(NSString*)name;


@end
