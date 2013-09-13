//
//  SOMAFullScreenBannerDelegate.h
//  iSoma
//
//  Created by Bilge Ulusoy on 24.10.12.
//
//

#import <Foundation/Foundation.h>

@protocol SOMABannerViewDelegate;
@class SOMAFullScreenBanner;

/*!
	@protocol		SOMAFullScreenBannerDelegate
	
	@abstract		Delegate Protocol for FullScreen Banners.
	@discussion		All Methods are optional and are not required to be implemented. You may, however do so.
	@updated		2012-11-12
	@availability	Available since iSoma 6.0 and later.
*/
@protocol SOMAFullScreenBannerDelegate <SOMABannerViewDelegate>

@optional
/*!
	@method			fullScreenBannerWillDismiss:
	@methodgroup    Dismissing Banners

	@abstract       Invoked before the banner is dismissed.
	@discussion     Implement this method to perform any actions before the banner is dismissed (e.g. resume gameplay, resume music/video, etc.).
	@param          aBanner The banner which will be dismissed.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)fullScreenBannerWillDismiss:(SOMAFullScreenBanner *)aBanner;

/*!
	@method			fullScreenBannerDidDismiss:
	@methodgroup    Dismissing Banners

	@abstract       Invoked after the banner has been dismissed.
	@discussion     Implement this method to perform any actions after the banner has been dismissed.
	@param          aBanner The banner which has been dismissed.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)fullScreenBannerDidDismiss:(SOMAFullScreenBanner *)aBanner;

/*!
	@method			fullScreenBannerWillPresent:
	@methodgroup    Presenting Banners

	@abstract       Invoked before the banner presents.
	@discussion     Implement this method to perform any actions before the banner presents (e.g. pause gameplay, pause music/video, etc.),
	@param          aBanner The banner which will be presented.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)fullScreenBannerWillPresent:(SOMAFullScreenBanner *)aBanner;

/*!
	@method			fullScreenBannerDidPresent:
	@methodgroup    Presenting Banners

	@abstract       Invoked after the banner has been presented.
	@discussion     Implement this method to perform any actions after the banner has been presented.
	@param          aBanner The banner which has been presented.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)fullScreenBannerDidPresent:(SOMAFullScreenBanner *)aBanner;

/*!
	@method			fullScreenBannerDidOpenLandingPage:
	@methodgroup    Other Tasks

	@abstract       Invoked when the landing page has been openend.
	@discussion     Implement this method to perform any actions after the landing page has been opened.
	@param          aBanner The banner which openend the landing page.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)fullScreenBannerDidOpenLandingPage:(SOMAFullScreenBanner *)aBanner;

@end

