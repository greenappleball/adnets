//
//  SOMAFullScreenBanner.h
//  SOMASource
//
//  Created by Jocelyn Harrington on 12/1/10.
//  Copyright ©2009-10 Smaato, Inc.  All Rights Reserved.  Use of this software is subject to the Smaato Terms of Service. 
//
#pragma once
#import <UIKit/UIKit.h>
#import "SOMABannerView.h"
#import "SOMAAdListenerProtocol.h"
#import "SOMAAdDownloaderProtocol.h"
#import "SOMAFullScreenBannerDelegate.h"

@interface SOMAFullScreenBanner : UIView<SOMAAdListenerProtocol,SOMABannerViewDelegate> {
	SOMABannerView *mBannerView;
	NSTimer *timer;
	UIButton *skipButton;
	UIActivityIndicatorView *spinner;
}
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) id<SOMAFullScreenBannerDelegate> delegate;
-(void)dismissBanner;
-(SOMAAdSettings*)adSettings;
-(void)setAdSettings:(SOMAAdSettings*)adSettings;
-(void)addAdListener:(id<SOMAAdListenerProtocol>)adListener;
-(void)removeAdListener:(id<SOMAAdListenerProtocol>)adListener;
@end
