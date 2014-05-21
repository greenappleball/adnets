#pragma once


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


/*!
	@enum			SOMAGender
	@methodgroup	Constants
	
	@abstract		Gender Constants.
	@constant		kSOMAGenderUnset Unset gender.
	@constant		kSOMAGenderMale Male gender.
	@constant		kSOMAGenderFemale Female gender.
	@availability	Available since iSoma 4.0 and later.
*/
typedef enum {
	kSOMAGenderUnset,
	kSOMAGenderMale,
	kSOMAGenderFemale
} SOMAGender;

// Not needed do document this
@interface SOMAGenderEnumConverter : NSObject {
}
+(NSString*)stringForValue:(SOMAGender) value;
@end

/*!
	@class			SOMAUserSettings
	
	@abstract		User Settings.
	@discussion		Settings for different targeting Parameters.
	@updated		2013-06-18
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAUserSettings : NSObject

/*!
	@property		userGender
	@methodgroup    User Settings

	@abstract       Targeting parameter for UserGender. Default is `kSOMAGenderUnset`.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) SOMAGender userGender;

/*!
	@property		age
	@methodgroup    User Settings

	@abstract       Targeting parameter for Age.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) NSInteger age;

/*!
	@property		keywordList
	@methodgroup    User Setings

	@abstract       Comma-seperated keyword list.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic,copy) NSString *keywordList;

/*!
	@property		searchQuery
	@methodgroup    User Settings

	@abstract       Targeting parameter for SearchQuery.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic,copy) NSString *searchQuery;

/*!
	@property		region
	@methodgroup    User Settings

	@abstract       Targeting parameter for Region.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic,copy) NSString *region;

/*!
	@property		country
	@methodgroup    User Settings

	@abstract       Targeting parameter for Country.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic,copy) NSString *country;

/*!
	@property		countryCode
	@methodgroup    User Settings

	@abstract       Targeting parameter for CountryCode.
    @availability	Available since iSoma 6.0 and later.
*/
@property (nonatomic,copy) NSString *countryCode;

/*!
	@property		city
	@methodgroup    User Settings

	@abstract       Targeting parameter for City
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic,copy) NSString *city;

/*!
	@property		zip
	@methodgroup    User Settings

	@abstract       Targeting parameter for zip code.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic,copy) NSString *zip;

/*!
	@property		latitude
	@methodgroup    User Settings

	@abstract       Targeting parameter for Latitude.
    @availability	Available since iSoma 4.0 and later.
	@deprecated		Deprecated since iSoma 6.0. Use the `coordinate` property instead.
*/
@property (nonatomic) double latitude DEPRECATED_ATTRIBUTE;

/*!
	@property		longitude
	@methodgroup    User Settings

	@abstract       Targeting parameter for Longitude.
    @availability	Available since iSoma 4.0 and later.
	@deprecated		Deprecated since iSoma 6.0. Use the `coordinate` property instead.
*/
@property (nonatomic) double longitude DEPRECATED_ATTRIBUTE;

/*!
	@property		coordinate
	@methodgroup    User Settings

	@abstract       Targeting parameter for latitude and longitude as 2D coordinate.
	@sa				CLLocationCoordinate2D
	@sa				latitude
	@sa				longitude
    @availability	Available since iSoma 6.0 and later.
*/
@property (nonatomic, assign, readwrite) CLLocationCoordinate2D coordinate;

/*!
	@property		userProfileEnabled
	@methodgroup    User Settings

	@abstract       Targeting parameter for userProfileEnabled.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, readwrite) BOOL userProfileEnabled;

/*!
	@property		coppa
	@methodgroup    User Settings

	@abstract       Determines wheter `COPPA` should be used or not. Default is `NO`.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, readwrite) BOOL COPPA;

/*!
	@method			requestString
	@methodgroup    Other

	@abstract       Returns the request string that is sent to the soma server.
    @result         Request as `NSString`.
    @availability	Available since iSoma 4.0 and later.
*/
- (NSString*)requestString;

@end


