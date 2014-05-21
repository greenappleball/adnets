#pragma once
#import <Foundation/Foundation.h>

/*!
	@enum			SOMABannerStatus
	@methodgroup	Constants
	
	@abstract		Status of the received banner.
	@constant		kSOMABannerStatusSuccess The banner download was successfull.
	@constant		kSOMABannerStatusError There was an error during banner download.
	@availability	Available since iSoma 4.0 and later.
*/
typedef enum {
	kSOMABannerStatusSuccess = 0,
	kSOMABannerStatusError
} SOMABannerStatus;

/*!
	@class			SOMABannerStatusEnumConverter
	
	@abstract		Class to convert the enum values to their corresponding string representations and back.
	@updated		2012-10-30
	@availability	Available since iSoma 4.0 and later.
*/
DEPRECATED_ATTRIBUTE @interface SOMABannerStatusEnumConverter : NSObject

/*!
	@method			stringForValue:
	@methodgroup    Converting Values and Strings

	@abstract       Returns the string for the given enum value or @"" if the value is unset.
	@param          value A valid `SOMABannerStatus` value.
    @result         A `NSString` representing the given value.
    @availability	Available since iSoma 4.0 and later.
*/
+ (NSString *)stringForValue:(SOMABannerStatus)value;

/*!
	@method			valueForString:
	@methodgroup    Converting Values and Strings

	@abstract       Returns the enum value for the given string or the value with cardinality 0 if the string is not found.
	@param          string A `NSString` representing a `SOMABannerStatus`.
    @result         A valid `SOMABannerStatus` value.
    @availability	Available since iSoma 4.0 and later.
*/
+ (SOMABannerStatus)valueForString:(NSString *)string;

@end

