//
//  BannerView.h
//  SOMADemo
//
//  Created by Gerrit Alves on 01.07.11.
//  Copyright 2011 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef ARMV6
#import <MediaPlayer/MediaPlayer.h>
#endif
#import <QuartzCore/QuartzCore.h>
#import "SOMAAdDownloading.h"
#import "SOMAAdDownloaderDelegate.h"
#import "SOMABannerViewDelegate.h"
#import "SOMAAdDimensionEnum.h"
#import "SOMAReceivedBanner.h"

/*!
	@enum			SOMAAnimationType
	@methodgroup	Constants
	
	@abstract		Banner animations.
	@constant		kSOMAAnimationTypeRandom Random animation.
	@constant		kSOMAAnimationTypeMoveIn Move-in animation.
	@constant		kSOMAAnimationTypePush Push animation, similar to the animation of [UINavigationController pushViewController:animated:].
	@constant		kSOMAAnimationTypeReveal Reveal animation.
	@constant		kSOMAAnimationTypeFade Fade animation.
	@constant		kSOMAAnimationTypeNone Disable animations.
	@availability	Available since iSoma 4.0 and later.
*/
typedef enum {
	kSOMAAnimationTypeRandom   = 0,
	kSOMAAnimationTypeMoveIn   = 1,
	kSOMAAnimationTypePush     = 2,
	kSOMAAnimationTypeReveal   = 3,
	kSOMAAnimationTypeFade     = 4,
	kSOMAAnimationTypeNone     = 5
} SOMAAnimationType;

/*!
	@enum			SOMAAnimationDirection
	@methodgroup	Constants
	
	@abstract		Control of animation Direction.
	@constant		kSOMAAnimationDirectionRandom Random direction.
	@constant		kSOMAAnimationDirectionLeft Using left as starting point.
	@constant		kSOMAAnimationDirectionRight Right as starting point.
	@constant		kSOMAAnimationDirectionTop Animation from top.
	@constant		kSOMAAnimationDirectionBottom Animation starts at the bottom.
	@availability	Available since iSoma 4.0 and later.
*/
typedef enum {
	kSOMAAnimationDirectionRandom = 0,
    kSOMAAnimationDirectionLeft     = 1,
	kSOMAAnimationDirectionRight    = 2,
	kSOMAAnimationDirectionTop      = 3,
	kSOMAAnimationDirectionBottom   = 4
} SOMAAnimationDirection;

@class SOMAAutoReloadTimer;
@class ORMMAConnector;
@class SOMAYouTubeView;
@class SOMAAdDownloader;

/*!
	@class			SOMABannerView
	
	@abstract		Used to present advertisements.
	@discussion		This is the standard class to create banner views. Please ensure that you're setting your adpsace and publisher id before sending
 it to the App Store. `SOMABannerView` supports the following ad types:<br />
 <ul>
 <li><code>kSOMAAdTypeAll</code> All ad types will be received (default).</li>
 <li><code>kSOMAAdTypeText</code> Load text ads only.</li>
 <li><code>kSOMAAdTypeImage</code> Load image ads only.</li>
 <li><code>kSOMAAdTypeRichMedia</code> Load rich-media ads only.</li>
 <li><code>kSOMAAdTypeVideo</code> Load video ads only.</li>
 </ul>
 Find an example on how to create banner views below:
	- (void)viewDidLoad {
		SOMABannerView *bannerView = [[SOMABannerView alloc] initWithDimension:kSOMAAdDimensionDefault];
		// Publisher settings
		bannerView.adSettings.publisherId = 0;
		bannerView.adSettings.adspaceId = 0;
		bannerView.adSettings.adType = kSOMAAdTypeAll;
 
		bannerView.autoReloadEnabled = YES; 
		[self.view addSubview:bannerView];
 
		[bannerView release], bannerView = nil;
	}
 <br />
 If you want to be notified of new banners you can either listen for the following notifications: `kSOMAAdDownloaderDidReceiveAdNotification` and `kSOMAAdDownloaderDidFailNotification`, or simply use the `-asyncLoadNewBannerWithCompletionHandler:` Method. These notifications are fired
 whenever a new banner has been received or an error occured. Each time a new banner arrives `kSOMAAdDownloaderDidReceiveAdNotification` is sent. If anything went wrong, `kSOMAAdDownloaderDidFailNotification` is sent. To stay
 up to date implement the methods like this:
	- (void)viewWillAppear:(BOOL)animated {
		// ...
		__block id <SOMAReceivedBanner> receivedBanner = nil;
		_didReceiveAdObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kSOMAAdDownloaderDidReceiveAdNotification
																				  object:nil
																				   queue:[NSOperationQueue mainQueue]
																			  usingBlock:^(NSNotification *note) {
															receivedBanner = (id <SOMAReceivedBanner>)[[note userInfo] objectForKey:kSOMAAdDownloaderUserInfoDictionaryReceivedBannerKey];
																		   }];
 
		_didFailObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kSOMAAdDownloaderDidFailNotification
																			 object:nil
																			  queue:[NSOperationQueue mainQueue]
																		 usingBlock:^(NSNotification *note) {
															NSError *bannerError = (NSError *)[[note userInfo] objectForKey:kSOMAAdDownloaderUserInfoDictionaryErrorKey];
																			}];

		// ...
	}
	
	- (void)viewWillDisappear:(BOOL)animated {
		// ...
		[[NSNotificationCenter defaultCenter] removeObserver:_didReceiveAdObserver], _didReceiveAdObserver = nil;
		[[NSNotificationCenter defaultCenter] removeObserver:_didFailObserver], _didFailObserver = nil;
		// ...
	}
 
 Use either the above described notifications or the `-asyncLoadNewBannerWithCompletionHandler:` Method. Using **both** will result in bad user experience.<br />Please note, that you're **not** forced to implement this method.
 
 <h3>AdWhirl Integration</h3>
 In case you're using [AdWhirl](https://www.adwhirl.com) take a look at the following example.
	- (void)somaCall:(AdWhirlView *)aView {	
		// Check if in full screen mode
		if (_fullScreen == YES) {
			return;
		}
	
		[_bannerView removeFromSuperview];
		[_bannerView release], _bannerView = nil;

		_bannerView = [[SOMABannerView alloc] initWithDimension:kSOMAAdDimensionDefault];
 
		[_bannerView adSettings].adspaceId = 0; // Set your adspace id
		[_bannerView adSettings].publisherId = 0; // Set your publisher id
	
		_bannerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		_bannerView.delegate = self;
		[_bannerView asyncLoadNewBanner];
		[adWhirlView replaceBannerViewWith:_bannerView];
	}
	
	- (void)landingPageWillBeDisplayed {
		_fullScreen = YES;
	}

	- (void)landingPageHasBeenClosed {
		_fullScreen = NO;
	}
 In this example, `somaCall:` is the remote method you entered in your Adwhirl account.
 @warning It's highly recommended to call AdWhirl's `-replaceBannerViewWith:` inside the `somaCall:` method. Otherwhise you'll experience unexpected behavior of the ads.
	
	@updated		2013-06-18
	@availability	Available since iSoma 4.0 and later.
*/

@interface SOMABannerView : UIView<SOMAAdDownloading, UIWebViewDelegate, SOMAAdDownloaderDelegate> {
    SOMAAdDownloader *mDownloader;
    BOOL mLoading;
    NSObject<SOMAReceivedBanner>* mLastReceivedBanner;
    UIView * mCurrentView;
    UIView * mLastView;
    UIActivityIndicatorView * mActivityIndicator;
#ifndef ARMV6
    MPMoviePlayerController* mMoviePlayer;
    BOOL mPlayingVideo;
    BOOL mLoadingVideo;
#endif
    SOMAAutoReloadTimer * mReloadTimer;
    ORMMAConnector* mORMMAConnector;
}

/*!
	@property		animationType
	@methodgroup    Animations

	@abstract       Animation Type which should be used.
	@discussion		Default value is `kSOMAAnimationTypeRandom`.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) SOMAAnimationType animationType;

/*!
	@property		animationDirection
	@methodgroup    Animations

	@abstract       Animation's Direction which should be used.
	@discussion		Default value is `kSOMAAnimationDirectionRandom`.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) SOMAAnimationDirection animationDirection;

/*!
	@property		delegate
	@methodgroup    Delegate

	@abstract       An assignment to an instance which implements the `SOMABannerViewDelegate` protocol
    @availability	Available since iSoma 4.0 and later.
	@see			SOMABannerViewDelegate
*/
@property (nonatomic, assign) id<SOMABannerViewDelegate> delegate;

/*!
	@property		backgroundColor
	@methodgroup    Other

	@abstract       Set the backgroundColor.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, retain) UIColor* backgroundColor;


/*!
	@method			initWithDimension:
	@methodgroup    Creating BannerViews

	@abstract       Returns a newly created `SOMABannerView` object or nil if the object couldn't be created.
	@param          dimension A valid `SOMAAdDimension` value.
    @result         A newly created `SOMABannerView` object.
    @availability	Available since iSoma 4.0 and later.
*/
- (id)initWithDimension:(SOMAAdDimension)dimension;

/*!
	@method			initWithDimension:publisher:adspace:
	@methodgroup    Creating BannerViews

	@abstract       Returns a newly created `SOMABannerView` object or nil if the object couldn't be created.
	@discussion		Convenient method to create a new `SOMABannerView` object with given parameters.
	@param          dimension A valid `SOMAAdDimension` value.
	@param			publisherID Publisher ID.
	@param			adspaceID Adspace ID.
    @result         A newly created `SOMABannerView` object.
    @availability	Available since iSoma 6.0 and later.
*/
- (id)initWithDimension:(SOMAAdDimension)dimension publisher:(NSInteger)publisherID adspace:(NSInteger)adspaceID;

/*!
	@method			createAnimation:
	@methodgroup    Animations

	@abstract       Returns a new `CATransition` object, based on the passed values.
	@discussion     Creates and returns a newly created `CATransition` object with the given values or nil if the object couldn't be created.
	@param          control A valid `SOMAAnimationType` value.
	@param			direction A valid `SOMAAnimationDirection` value.
    @result         A newly created `CATransition` object.
    @availability	Available since iSoma 4.0 and later.
*/
- (CATransition*)createAnimation:(SOMAAnimationType)control withDirection:(SOMAAnimationDirection)direction;

/*!
	@method			stopVideoPlayback
	@methodgroup    Other

	@abstract       Stops video playback if it's playing.
    @availability	Available since iSoma 4.0 and later.
*/
- (void)stopVideoPlayback;

@end
