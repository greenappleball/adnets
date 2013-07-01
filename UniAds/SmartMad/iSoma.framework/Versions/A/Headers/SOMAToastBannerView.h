//
//  ToastBannerView.h
//  SOMADemo
//
//  Created by Gerrit Alves on 01.07.11.
//  Copyright 2011 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMAAdDownloading.h"
#import "SOMABannerView.h"

/*!
	@class			SOMAToastBannerView
	
	@abstract		Toast-animatied BannerView.
	@discussion		This class is used to create a toast-animated BannerView.
	@updated		2012-11-12
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAToastBannerView : UIView <SOMAAdDownloading, SOMABannerViewDelegate> {
    UIButton * mCloseButton;
    SOMABannerView * mBannerView;
	id addownloader_success_observer;
	id addownloader_failure_observer;
}

/*!
	@property		delegate
	@methodgroup    Other

	@abstract       Delegate reference.
    @availability	Available since iSoma 4.0 and later.
	@seealso		[SOMABannerViewDelegate]
*/
@property (nonatomic, assign) id<SOMABannerViewDelegate> delegate;

/*!
	@property		backgroundColor
	@methodgroup    Other

	@abstract       Used to set and/or get the background color of the banner view.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, retain) UIColor* backgroundColor;

@end
