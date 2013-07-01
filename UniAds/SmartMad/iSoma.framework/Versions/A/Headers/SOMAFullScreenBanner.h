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
#import "SOMAFullScreenBannerDelegate.h"

/*!
	@class			SOMAFullScreenBanner
	
	@abstract		Full Screen Banners.
	@discussion		This class provides a full screen banner.
	@updated		2012-11-12
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAFullScreenBanner : UIView <SOMABannerViewDelegate> {
	SOMABannerView *mBannerView;
	NSTimer *timer;
	UIButton *skipButton;
	UIActivityIndicatorView *spinner;
	id addownloader_success_observer;
	id addownloader_failure_observer;
}


@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) id<SOMAFullScreenBannerDelegate> delegate;

/*!
	@method			dismissBanner
	@methodgroup    Other

	@abstract       Dismisses the `SOMAFullScreenBanner` object.
    @availability	Available since iSoma 4.0 and later.
*/
- (void)dismissBanner;

/*!
	@method			adSettings
	@methodgroup    Setting and getting Ad Settings

	@abstract       Returns a `SOMAAdSettings` object.
    @result         A `SOMAAdSettings` object.
    @availability	Available since iSoma 4.0 and later.
	@see			SOMAAdSettings
*/
- (SOMAAdSettings*)adSettings;

/*!
	@method			setAdSettings:
	@methodgroup    Setting and getting Ad Settings

	@abstract       Replaces current ad settings with the passed object.
	@param          adSettings A `SOMAAdSettings` object.
    @availability	Available since iSoma 4.0 and later.
	@see			SOMAAdSettings
*/
- (void)setAdSettings:(SOMAAdSettings*)adSettings;

@end
