#pragma once
#import <Foundation/Foundation.h>

/*!
	@enum			SOMAAdType
	@methodgroup	Constants
	
	@abstract		All possible values of banner types.
	@constant		kSOMAAdTypeAll Requests a banner of any type (except video).
	@constant		kSOMAAdTypeImage Request an image banner.
	@constant		kSOMAAdTypeText Requests a text banner.
	@constant		kSOMAAdTypeVideo Requests a video banner.
	@constant		kSOMAAdTypeRichMedia Requests a rich media banner.
	@availability	Available since iSoma 4.0 and later.
*/
typedef enum {
	kSOMAAdTypeAll = 0,
	kSOMAAdTypeImage,
	kSOMAAdTypeText,
	kSOMAAdTypeVideo,
	kSOMAAdTypeRichMedia
} SOMAAdType;

/*!
	@class			SOMAAdTypeEnumConverter
	
	@abstract		Class to convert the enum values to their corresponding string representations and back.
	@discussion		This class is usually only used internally and not needed for publishers.
	@updated		2012-10-30
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAAdTypeEnumConverter : NSObject


/*!
	@method			stringForValue:
	@methodgroup    Converting Values and Strings

	@abstract       Returns the string for the given enum value or @"" if the value is unset.
	@param          value A valid `SOMAAdType` value.
    @result         A `NSString` representing the given value.
    @availability	Available since iSoma 4.0 and later.
*/
+ (NSString *)stringForValue:(SOMAAdType)value;

/*!
	@method			valueForString:
	@methodgroup    Converting Values and Strings

	@abstract       Returns the enum value for the given string or the value with cardinality 0 if the string is not found.
	@param          string A `NSString` representing a `SOMAAdType`.
    @result         A valid `SOMAAdType` value.
    @availability	Available since iSoma 4.0 and later.
*/
+ (SOMAAdType)valueForString:(NSString *)string;

@end

