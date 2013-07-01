#pragma once
#import <Foundation/Foundation.h>

/*!
	@typedef		SOMAAdDimension
	@indexgroup		Tasks
	@methodgroup	Constants
	
	@abstract		Enumeration for ad dimensions.
	@discussion		These enum constants are used for the SOMAAdSettings.
	@constant		kSOMAAdDimensionDefault Default ad dimension MMA (320x50).
	@constant		kSOMAAdDimensionMediumRectangle Medium rectangle banner.
	@constant		kSOMAAdDimensionLeaderboard Leaderboard banners are only available on tablets.
	@constant		kSOMAAdDimensionSkyscraper Skyscraper are also only available on tablets.
*/
typedef enum {
	kSOMAAdDimensionDefault = 0,
	kSOMAAdDimensionMediumRectangle,
	kSOMAAdDimensionLeaderboard,
	kSOMAAdDimensionSkyscraper
} SOMAAdDimension;

/*!
	@class		SOMAAdDimensionEnumConverter

	@abstract	Convert enums to strings and vice-versa.
	@discussion	Class to convert the enum values to their corresponding string representations and back.
	@updated	2012-10-29
*/
@interface SOMAAdDimensionEnumConverter : NSObject

/*!
	@method			stringForValue:
	@methodgroup    Converting Values

	@abstract       Converts given value to a NSString.
	@discussion     Converts and returns passed value as NSString or an empty string if value is unset.
	@param          value A SOMAAdDimension enum constant.
    @result         Value as NSString.
*/
+ (NSString *)stringForValue:(SOMAAdDimension)value;

/*!
	@method			valueForString:
	@methodgroup    Converting Values

	@abstract       Converts given string to a SOMAAdDimension value.
	@discussion     Converts and returns passed value as SOMAAdDimension enum constant or with cardinality 0 if the string is nout found.
	@param          string A NSString which needs to be converted.
    @result         SOMAAdDimension constant.
*/
+ (SOMAAdDimension)valueForString:(NSString *)string;

@end

