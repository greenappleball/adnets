#pragma once

#import "SOMAReceivedBanner.h"
@protocol SOMAAdDownloading;

/*!
	@protocol		SOMAAdDownloaderDelegate
	
	@abstract		Ad Listener Protocol.
	@discussion		This protocol is designed to work together with the `SOMAAdDownloading` and `SOMAReceivedBanner` protocol.
	@updated		2013-02-11
	@availability	Available since iSoma 6.0 and later.
*/
@protocol SOMAAdDownloaderDelegate <NSObject>

/*!
	@method			adDownloader:didReceiveBanner
	@methodgroup    Receiving Banners

	@abstract       Called when a new banner has been received and is about to be displayed.
	@discussion     Each time a banner has been received this method is called on all ad listeners.
	@param          aDownloader The object which implements the `SOMAAdDownloading` and therefore sends the banner.
	@param			aReceivedBanner A newly created banner which conforms to the `SOMAReceivedBanner` protocol.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)adDownloader:(id<SOMAAdDownloading>)aDownloader didReceiveBanner:(id<SOMAReceivedBanner>)aReceivedBanner;

/*!
	@method			adDownloader:didFailWithError:
	@methodgroup    Receiving Banners

	@abstract       Called when something went wrong.
	@discussion     This method is invoked when a banner retrieval was not successfull.
	@param          aDownloader The object which implements the `SOMAAdDownloading` and therefore sends the banner.
	@param			anError A `NSError` object containting the failure information.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)adDownloader:(id<SOMAAdDownloading>)aDownloader didFailWithError:(NSError *)anError;

@end
