#pragma once
#import <Foundation/Foundation.h>


/*!
	@enum			SOMAErrorCode
	@methodgroup	Constants
	
	@abstract		All possible errors that can occur during the banner request.
	@constant		kSOMAErrorCodeNoError No error.
	@constant		kSOMAErrorCodeUnknownPublisherOrAdspaceId Invalid publisher and/or adspace id.
	@constant		kSOMAErrorCodeNoConnectionError The system is unable to connect to the smaato server.
	@constant		kSOMAErrorCodeNoAdAvailable Currently no ad available.
	@constant		kSOMAErrorCodeGeneralError General Error. Inspect error message for further details.
	@constant		kSOMAErrorCodeParsingError Error during response parsing.
	@availability	Available since iSoma 4.0 and later.
*/
typedef enum {
	kSOMAErrorCodeNoError = 0,
	kSOMAErrorCodeUnknownPublisherOrAdspaceId,
	kSOMAErrorCodeNoConnectionError,
	kSOMAErrorCodeNoAdAvailable,
	kSOMAErrorCodeGeneralError,
	kSOMAErrorCodeParsingError
} SOMAErrorCode;

/*!
	@class			SOMAErrorCodeEnumConverter
	
	@abstract		Class to convert the enum values to their corresponding string representations and back.
	@discussion		This class is used mostly internally and doesn't need any user interaction.
	@updated		2012-11-12
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAErrorCodeEnumConverter : NSObject {
}

/*!
	@method			stringForValue:
	@methodgroup    Converting Values

	@abstract       Returns a NSString for the enum value.
	@discussion     Creates and returns a NSString object with the given value or @"" if the value is unset or invalid.
	@param          value A SOMAErrorCode value.
    @result         SOMAErrorCode Value as NSString.
    @availability	Available since iSoma 4.0 and later.
*/
+ (NSString *)stringForValue:(SOMAErrorCode)value;

/*!
	@method			valueForString:
	@methodgroup    Converting Values

	@abstract       Returns the enum value for the given string.
	@discussion     Returns the enum value for the given string or the value with cardinality 0 if the string is not found.
	@param          string String to be converted.
    @result         A SOMAErrorCode value.
    @availability	Available since iSoma 4.0 and later.
*/
+ (SOMAErrorCode)valueForString:(NSString *)string;

@end

