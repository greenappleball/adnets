//
//  MBSBaseMediatorDelegate.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 5/30/12.
//  Copyright (c) 2012 The Rubicon Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBSUtils.h"
@class MBSAdPrivateView;
@class MBSBaseMediator;
@protocol MBSBaseMediatorDelegate <NSObject>

@required
- (UIViewController *)viewControllerForPresentingModalView;
-(void)mediator:(MBSBaseMediator *)mediator didFailToLoadAdWithError:(NSError *)error;
-(void)mediator:(MBSBaseMediator *)mediator didFinishLoadingAd:(UIView *)adView;

-(MBSAdPrivateView *)pvtAdView;

-(adLoadingStatusTypes)getAdLoadingStatus;
-(void)changeAdLoadingStatus:(adLoadingStatusTypes)newStatus;
-(void)changeAdStatusToPrev;
-(BOOL) isPlacementInterstitial;

@optional

// Sent just before presenting a full ad landing view, in response to clicking
// on an ad. Use this opportunity to stop animations, time sensitive interactions, etc.
-(void)mediator:(MBSBaseMediator *)mediator willPresentFullScreenModalFromAd:(UIView *)adView
      withFrame:(CGRect)frame isEmbedded:(BOOL)embedded;  
// Sent just after presenting a full ad landing view, in response to clicking
// on an ad
-(void)mediator:(MBSBaseMediator *)mediator  didPresentFullScreenModalFromAd:(UIView *)adView 
      withFrame:(CGRect)frame isEmbedded:(BOOL)embedded;

// Sent just before dismissing the full ad landing view, in response to clicking
// of close/done button on the landing view
-(void)mediator:(MBSBaseMediator *)mediator willDismissFullScreenModalFromAd:(UIView *)adView isEmbedded:(BOOL)embedded;

// Sent just after dismissing a full screen view. Use this opportunity to
// restart anything you may have stopped as part of -willPresentFullScreenModalFromAd:.
-(void)mediator:(MBSBaseMediator *)mediator didDismissFullScreenModalFromAd:(UIView *)adView isEmbedded:(BOOL)embedded;



//Interstitial
-(void)mediator:(MBSBaseMediator *)mediator willDismissInterstitial:(UIView *)adView;
-(void)mediator:(MBSBaseMediator *)mediator didDismissInterstitial:(UIView *)adView;

-(void)mediator:(MBSBaseMediator *)mediator swapAdViewWithNewView:(UIView *)adView;
-(void)mediator:(MBSBaseMediator *)mediator willResizeAdView:(UIView *)view toFrame:(CGRect)newFrame isModal:(BOOL)modal;



@end
