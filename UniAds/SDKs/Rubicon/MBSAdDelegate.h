//
//  MBSAdDelegate.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 5/10/12.
//  Copyright (c) 2012 the Rubicon Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBSAdView;
@protocol MBSAdDelegate<NSObject>

@required
#pragma mark -
#pragma mark Required Methods

//The View controller which originated ad request. 
//For best results, please return the view controller whose content view covers full
//screen(apart from tabbar,nav bar and status bar. If the view controller which 
//requested for ads does not have full screen access then return the parent view controller
//which has full screen access.
-(UIViewController *)currentViewControllerForMBSAd:(MBSAdView *)mbsAdView;

@optional
#pragma mark -
#pragma mark Optional Notification Methods
// Sent when an ad request has been made to the Server. Useful for checking the
// request URL.
- (void)didRequestAd:(MBSAdView *)adView withUrl:(NSString *)requestUrlString;

// Sent when an ad request loaded an ad; this is a good opportunity to add
// this view to the hierachy, if it has not yet been added.
- (void)didReceiveAd:(MBSAdView *)adView;

// Sent when an ad request failed to load an ad.This is a good opportunity to
// remove the adview from superview if it has been added
// Note that if backfill is enabled, failure will be returned only if there are
// no RFM Ads and AdMob also failed to render a valid ad.
// If RFM failed to get an ad from RFM server, but found a backfill ad 
// on AdMob, the delegate will receive didReceiveAd: notification.
- (void)didFailToReceiveAd:(MBSAdView *)adView;

// sent when ad is displayed
- (void)didDisplayAd:(MBSAdView *)adView;

// sent when ad fails to display
- (void)didFailToDisplayAd:(MBSAdView *)adView;

// Sent just before presenting a full ad landing view, in response to clicking
// on an ad. Use this opportunity to stop animations, time sensitive interactions, etc.
- (void)willPresentFullScreenModalFromAd:(MBSAdView *)adView;

// Sent just after presenting a full ad landing view, in response to clicking
// on an ad
- (void)didPresentFullScreenModalFromAd:(MBSAdView *)adView;

// Sent just before dismissing the full ad landing view, in response to clicking
// of close/done button on the landing view
- (void)willDismissFullScreenModalFromAd:(MBSAdView *)adView;

// Sent just after dismissing a full screen view. Use this opportunity to
// restart anything you may have stopped as part of -willPresentFullScreenModalFromAd:.
- (void)didDismissFullScreenModalFromAd:(MBSAdView *)adView;

// Sent if the application will enter background (user touched home button, or clicked
// a button which triggered another application and sent the current application in
// background) while the ad banner was still loading.
// Prior to calling this function, MBSAdView will stop loading the banner 
//
// Recommendation for publishers: We recommend that you handle this delegate callback 
// and remove the MBSAdView instance from superview when you receive this callback.
- (void)adViewDidStopLoadingAndEnteredBackground:(MBSAdView *)adView;

// Sent just before dismissing the interstitial view, in response to clicking
// of close/done button on the interstitial ad
-(void)willDismissInterstitialFromAd:(MBSAdView *)adView;

// Sent just after dismissing the interstitial view, in response to clicking
// of close/done button on the interstitial ad
-(void)didDismissInterstitial;


@end
