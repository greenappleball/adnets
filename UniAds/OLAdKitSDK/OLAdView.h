//
//  OLAdView.h
//  Slices
//
//  Created by Alex Volovoy.
//  Copyright (c) 2012 OneLouder Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLAdManager.h"
 
//Ad Sizes
#define BANNER_RECT CGRectMake(0, 0, 320, 50)
#define SQUARE_RECT CGRectMake(0, 0, 320, 250)
#define BANNER_LONG_RECT CGRectMake(0, 0, 768, 90)

@protocol OLAdViewDelegate;

// View for displaying the ads.  Add this to your main view.
@interface OLAdView : UIView

@property (nonatomic, assign) id<OLAdViewDelegate> delegate;
@property (nonatomic, readonly)BOOL isAdmanagerViewParent;
@property (nonatomic, retain, readonly ) UIButton *btnClose;
@property (nonatomic, strong) NSString *adPlacement;
@property (nonatomic, assign) OLAdType adType;
@property (nonatomic, readonly) BOOL hasAd;
@property (nonatomic, strong) UIColor* textAdBackgroundColor;

- (id)initWithFrame:(CGRect)frame adPlacement:(NSString*)placement withAdType:(OLAdType)adType;
- (void)setupViewsAndReloadAd:(BOOL)reload;
- (CGRect)adViewFrame;
- (void)getAdWithNotification;
- (void)stop;
@end


@protocol OLAdViewDelegate <NSObject>
// Returns the view controller that will be responsible for displaying modal views.
// This is mostly used when the SDK needs to takeover full screen (such as when an ad is clicked).
// NOTE: As of iOS 6 the app now controls which orientations can be used by ads/in-app browser in either the Info.plist or in the AppDelegate application:supportedInterfaceOrientationsForWindow: method.
// We recommend for maximum compatibility with RichMedia ads that your app enables all orientations and then programatically restricts orientations where necessary using the UIViewController supportedInterfaceOrientations method.
@property (nonatomic,readonly) UIViewController *adTopViewController;

@optional
// Callbacks to let the app know that the full screen web view has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the web view is being viewed (i.e. for a game).  You might also want to get a new ad when the full screen closes.
- (void) fullScreenWebViewActivated;
- (void) fullScreenWebViewClosed;

// Callbacks to let the app know that an ad has just expanded or collapsed.  This means that an ad is taking up part of the screen but interaction with various elements of the app may still be possible.
// If it has expanded then the ad is currently currently displaying over some of the content.  The app should keep track of this and call collapseAd if the user interacts with the app instead of the ad.
- (void) adDidExpand;
- (void) adDidCollapse;

// Callbacks to let the app know that a full screen interstitial has been activated and closed.
// These callbacks are useful if your app needs to pause any onscreen activity while the interstitial is being viewed and restart after it is closed.
// These are optional since fullScreenWebViewActivated and fullScreenWebViewClosed will be called as well in case only those are implemented.
- (void) interstitialActivated;
- (void) interstitialClosed;

// Callback to let app know that a special banner has been clicked.  This method is provided to help track if an ad click is respondible for sending the user out of the app.
// Either this method, fullScreenWebViewActivated, adDidExpand  should be called on ad click where supported.
// Examples click actions that would trigger this are click to call, click to app, click to itunes, etc.
// If the app is going to exit or go to the background the the normal UIApplicationDelegate methods will still get called after this.
// NOTE: Some ad network SDKs don't provide a tracking option for ads that don't open a full screen view so our SDK can't provide this additional information in those cases.
- (void) adViewWasClicked;

- (void)olAdView:(OLAdView *)olAdView adHiddenChanged:(BOOL)hidden;
- (void)olAdView:(OLAdView *)olAdView adLoaded:(BOOL)loaded;

// Space delimited keywords (ex: MOVIE CATS FUNNY)
- (NSString*)adKeywords;



@end