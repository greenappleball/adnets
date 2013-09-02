#pragma once

#import <Foundation/Foundation.h>
#import "SOMABannerStatusEnum.h"
#import "SOMAAdTypeEnum.h"
#import "SOMAErrorCodeEnum.h"

/*!
	@protocol		SOMAReceivedBanner
	
	@abstract		Received Banner.
	@discussion		Protocol which describes received banners.
	@updated		2013-01-30
	@availability	Available since iSoma 4.0 and later.
*/
@protocol SOMAReceivedBanner <NSObject>

@required

/*!
	@method			status
	@methodgroup    Received Banners

	@abstract       Returns the status of the received banner.
    @result         A `SOMABannerStatus` value.
    @availability	Available since iSoma 4.0 and later.
 	@see			SOMABannerStatus
	@deprecated		Deprecated since iSoma 6.0.
*/
- (SOMABannerStatus)status DEPRECATED_ATTRIBUTE;

/*!
	@property		richMediaData
	@methodgroup    Other

	@abstract       HTML snipped describing the received rich media banner.
    @availability	Available since iSoma 4.0 and later.
*/
@property (copy, nonatomic, readonly) NSData *richMediaData;

/*!
	@property		beacons
	@methodgroup    Other

	@abstract       List of beacons for this banner.
    @availability	Available since iSoma 4.0 and later.
*/
@property (copy, nonatomic, readonly) NSMutableArray *beacons;

/*!
	@method			mediaFile
	@methodgroup    Received Banners

	@abstract       Returns the URL to the received video banner as `NSString`.
    @result         A `NSString` containing the URL to the received video banner.
    @availability	Available since iSoma 4.0 and later.
 	@deprecated		Deprecated since iSoma 6.0, use `mediaFileURL` instead.
*/
- (NSString *)mediaFile DEPRECATED_ATTRIBUTE;

/*!
	@property		mediaFileURL
	@methodgroup    Other

	@abstract       A `NSURL` containing the URL to the received video banner.
    @availability	Available since iSoma 4.0 and later.
*/
@property (copy, nonatomic, readonly) NSURL *mediaFileURL;

/*!
	@property		adText
	@methodgroup    Other

	@abstract       A `NSString` representing the text banner.
    @availability	Available since iSoma 4.0 and later.
*/
@property (copy, nonatomic, readonly) NSString *adText;

/*!
	@method			imageUrl
	@methodgroup    Received Banners

	@abstract       Returns the url to the received image banner.
    @result         A `NSString` representing the URL to the received image banner.
	@availability	Available since iSoma 4.0 and later.
	@deprecated		Deprecated since iSoma 6.0. Use the `imageURL` method instead.
*/
- (NSString *)imageUrl DEPRECATED_ATTRIBUTE;

/*!
	@property		imageURL
	@methodgroup    Other

	@abstract       A `NSURL` object pointing at the received image banner.
    @availability	Available since iSoma 6.0 and later.
*/
@property (copy, nonatomic, readonly) NSURL *imageURL;

/*!
	@method			errorCode
	@methodgroup    Received Banners

	@abstract       Returns the error code of the received banner.
    @result         A `SOMAErrorCode` value.
    @availability	Available since iSoma 4.0 and later.
	@deprecated		Deprecated since iSoma 6.0. 
*/
- (SOMAErrorCode)errorCode DEPRECATED_ATTRIBUTE;

/*!
	@method			errorMessage
	@methodgroup    Received Banners

	@abstract       Returns the error message of the received banner.
	@discussion     If the error message is empty, this method returns nil.
    @result         A `NSString` containing the error message or nil.
    @availability	Available since iSoma 4.0 and later.
	@deprecated		Deprecated since iSoma 6.0.
*/
- (NSString *)errorMessage DEPRECATED_ATTRIBUTE;

/*!
	@property		adType
	@methodgroup    Other

	@abstract       Type of received banner.
    @availability	Available since iSoma 4.0 and later.
*/
@property (assign, nonatomic, readonly) SOMAAdType adType;

/*!
	@method			clickUrl
	@methodgroup    Received Banners

	@abstract       Returns the URL to the landing page.
    @result         A `NSString` representing the URL to the landing page.
    @availability	Available since iSoma 4.0 and later.
	@deprecated		Deprecated since iSoma 6.0. Use the `clickURL` method instead.
*/
- (NSString *)clickUrl DEPRECATED_ATTRIBUTE;

/*!
	@property		clickURL
	@methodgroup    Other

	@abstract        A `NSURL` representing the URL to the landing page.
    @availability	Available since iSoma 6.0 and later.
*/
@property (copy, nonatomic, readonly) NSURL *clickURL;

@end


