#pragma once


#import "SOMAAdTypeEnum.h"
#import "SOMAAdDimensionEnum.h"



/*!
	@class			SOMAAdSettings
	
	@abstract		Mutable Ad Settings.
	@discussion		Each `SOMABannerView` needs an instance of adsettings in order to make proper requests
	@updated		2012-10-30
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAAdSettings : NSObject

/*!
	@property		publisherId
	@methodgroup	Publisher Settings

	@abstract       Targeting parameter for publisher-id.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) NSInteger publisherId;

/*!
	@property		adspaceId
	@methodgroup    Publisher Settings

	@abstract       Targeting parameter for adspace-id.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) NSInteger adspaceId;

/*!
	@property		adType
	@methodgroup    Ad Settings

	@abstract       Targeting parameter for ad-type.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) SOMAAdType adType;

/*!
	@property		adDimension
	@methodgroup    Ad Settings

	@abstract       Targeting parameter for ad-dimension.
    @availability	Available since iSoma 4.0 and later.
	@see			SOMAAdDimension
*/
@property (nonatomic) SOMAAdDimension adDimension;

/*!
	@property		bannerWidth
	@methodgroup    Ad Settings

	@abstract       argeting parameter for banner-width.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) NSInteger bannerWidth;

/*!
	@property		bannerHeight
	@methodgroup    Ad Settings

	@abstract       Targeting parameter for banner-height.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) NSInteger bannerHeight;

/*!
	@method			requestString
	@methodgroup    Ad Requests

	@abstract       Returns the request string that is sent to the soma server.
	@discussion     Initializes and returns the request string with all parameters which is sent to the soma server.
    @result         Request string.
    @availability	Available since iSoma 4.0 and later.
*/
- (NSString*)requestString;

@end


