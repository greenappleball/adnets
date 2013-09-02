//
//  BannerViewDelegate.h
//  SOMADemo
//
//  Created by Gerrit Alves on 01.07.11.
//  Copyright 2011 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <Availability.h>
#import <EventKitUI/EventKitUI.h>

@class SOMABannerView;
@class SOMAYouTubeView;

/*!
	@protocol		SOMABannerViewDelegate
	
	@abstract		BannerView Delegate Protocol.
	@discussion		The `SOMABannerViewDelegate` protocol is used to inform the receiver of any changes regarding a `SOMABannerView` object.
 For example if your receiver needs to be informed when a landingpage has been displayed or closed, just implement the appropriate methods.
 All methods in the `SOMABannerViewDelegate` protocol are optional and you're not forced to implement them.
	@updated		2012-12-11
	@availability	Available since iSoma 4.0 and later.
*/
@protocol SOMABannerViewDelegate <NSObject>

@optional

/*!
	@method			landingPageWillBeDisplayed
	@methodgroup    Landing Pages

	@abstract       Invoked right before the landing page will be displayed.
    @availability	Available since iSoma 4.0 and later.
*/
- (void)landingPageWillBeDisplayed;

/*!
	@method			landingPageHasBeenClosed
	@methodgroup    Landing Pages

	@abstract       Invoked after the landing page has been closed.
    @availability	Available since iSoma 4.0 and later.
*/
- (void)landingPageHasBeenClosed;

/*!
	@method			shouldUseInAppStore
	@methodgroup    App Store

	@abstract       Returns a BOOL whether to use the App Store inside the app or not.
	@discussion     If no, or simply not implemented by your receiver, the app will leave itself and opends up the App Store on the device.
    @result         A BOOL indicating to use the App Store inside the app or not.
    @availability	Available since iSoma 5.2.2, iOS 6.0 and later.
*/
- (BOOL)shouldUseInAppStore; // __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);

/*!
	@method			didLoadInAppStore:
	@methodgroup    App Store

	@abstract       Invoked when the App Store has been loaded.
	@discussion     This method is invoked when the App Store successfully loaded itself. See the example below how to use it:
	- (void)didLoadInAppStore:(UIViewController *)aStore {
		[self.navigationController presentModalViewController:aStore animated:YES];
	}
	@param          aStore A `UIViewController` object, respective a `SKStoreProductViewController` object.
    @availability	Available since iSoma 5.2.2, iOS 6.0 and later.
	@see			SKStoreProductViewController
*/
- (void)didLoadInAppStore:(UIViewController *)aStore; // __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);

/*!
	@method			failedToLoadInAppStore:
	@methodgroup    App Store

	@abstract       Invoked when something went wrong while loading the App Store.
	@param          aStore  A `UIViewController` object, respective a `SKStoreProductViewController` object.
 	@param			anError A NSError object containing the error information.
    @availability	Available since iSoma 5.2.2, iOS 6.0 and later.
	@see			[SKStoreProductViewController loadProductWithParameters:completionBlock:]
*/
- (void)failedToLoadInAppStore:(UIViewController *)aStore error:(NSError *)anError; // __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);

/*!
	@method			didLoadCalendarEventViewController
	@methodgroup    Events

	@abstract       Invoked when the Calendar Event editing viewcontroller has been loaded.
	@discussion     This method is invoked when the Calendar Event has been parsed and loaded into the `EKEventEditViewController`. To show the
 controller see the example:
	- (void)didLoadCalendarEventViewController:(EKEventEditViewController *)viewController {
		[self.navigationController presentModalViewController:viewcontroller animated:YES];
	}
	@param          viewcontroller a newly created 
    @availability	Available since iSoma 6.0, iOS 4 and later.
*/
- (void)didLoadCalendarEventViewController:(EKEventEditViewController *)viewController;

/*!
	@method			shouldUseInAppYouTube
	@methodgroup    YouTube

	@abstract       Returns whether to use youtube inside the app or not.
	@discussion		Default return value is set to NO.
    @result         A BOOL indicating whether to use youtube inside the app or not.
    @availability	Available since iSoma 6.0, iOS 5.0 and later.
*/
- (BOOL)shouldUseInAppYouTube;

@end
