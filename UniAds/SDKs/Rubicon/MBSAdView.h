//
//  MBSAdView.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 5/10/12.
//  Copyright (c) 2012 The Rubicon Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSAdDelegate.h"
#import "MBSAdConstants.h"
#import "MBSAdRequest.h"

@interface MBSAdView : UIView

#pragma mark -
#pragma mark View Interface

{
  //Designate delegate for the AdView
  id<MBSAdDelegate> _delegate;
  
}

#pragma mark -
#pragma mark View Creation
//Use one of the three create functions to create an AdView. 
//We recommend to create a view once during the view controller creation
//and then use only the requestFreshAd method to refresh the view with new ads.


/*  If publishers want :
 -- a default (320x50) banner AND
 -- in a default position (top of content view below top navigation bar) AND 
 -- do not support rotation
 */
+ (MBSAdView *)createAdWithDelegate:(id<MBSAdDelegate>)adDelegate;


/*  If publishers want:
 -- a custom banner size AND
 -- custom banner location BUT
 -- do not support rotation  
 */
+ (MBSAdView *)createAdOfFrame:(CGRect)frame 
                    withCenter:(CGPoint)center
                  withDelegate:(id<MBSAdDelegate>)adDelegate;


/*
 If publishers want :
 -- a custom banner size which is same of both landscape and portrait AND
 -- custom banner location AND 
 -- support rotation
 */

//MBSAd will automatically detect rotation and resize 
+ (MBSAdView *)createAdOfFrame:(CGRect)frame 
            withPortraitCenter:(CGPoint)portraitCenter
           withLandscapeCenter:(CGPoint)landscapeCenter
                  withDelegate:(id<MBSAdDelegate>)adDelegate;



/*  If publishers want :
 -- a full screen interstitial ad
 */
+ (MBSAdView *)createInterstitialAdWithDelegate:(id<MBSAdDelegate>)adDelegate;

#pragma mark -
#pragma mark Ad Request
//Ad API to request an Ad once the AdView has been created.
//You can call this several times during the view lifecycle.
//The returned status shows whether the request was accepted by the SDK.
//For example, if the requestFreshAD function is called when the user 
//is viewing the landing page of a previous ad, the SDK does not initiate 
//a new ad request and instead returns BOOL “NO” as status.
- (BOOL)requestFreshAdWithRequestParams:(MBSAdRequest *)requestParams;

//This enables pre-caching of ads for interstitials only
- (BOOL)requestCachedAdWithRequestParams:(MBSAdRequest *)requestParams;

//API to inform MBSAdView that the controller has rotated to new orientation.
//If your controller supports view rotation, call this from the parent view controller's function :
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//  duration:(NSTimeInterval)duration
- (void) rotateAdViewToOrientation:(UIInterfaceOrientation)newOrientation; 


//In case the parent view controller's main view is getting unloaded due to low memory warning, 
//MBSAdView will be removed from the superview. Call this function from your view controller's
// -(void)viewDidUnload function to reset MBSAdView to its initial state
- (void) controllerViewDidUnload;

//Get the Version number of RFM SDK in use.
+ (NSString *)mbsAdVersion;

// API to adjust  adjust the adview placement for iOS7 and higher if parent view controller
// cannot set the edges for extended layout to none. Call this API for with the correct offset
// values to ensure that the adview is created at the desired coordinates
-(void)offsetCentersForiOS7WithPortaitOffset:(CGFloat)portraitOffset andLandscapeOffset:(CGFloat)landscapeOffset;

// Returns YES when ad can be displayed, NO otherwise
// Applies to cached ads only
- (BOOL)canDisplayAd;

// For cached ad, we must call showAd for display,
// Returns YES when ad can be shown, but if NO
// may also invoke didFailToDisplayAd delegate
- (BOOL)showAd;

@property (assign, setter = setDelegate:,getter = getDelegate) id<MBSAdDelegate> delegate;
@property (assign, readonly) BOOL shouldPrecache;

@end
