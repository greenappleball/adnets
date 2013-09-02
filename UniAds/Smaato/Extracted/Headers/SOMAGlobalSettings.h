//
//  SOMAGlobalSettings.h
//  iSoma
//
//  Created by Gerrit Alves on 28.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMAUserSettings.h"

/*!
	@enum			SOMALogLevel
	@methodgroup	Constants
	
	@abstract		Log Levels.
	@discussion		Different log levels for different purposes.
	@constant		kSOMALoglevelNone Logs nothing.
	@constant		kSOMALoglevelError Only errows will be logged.
	@constant		kSOMALogLevelWarning Logs warnings and errors.
	@constant		kSOMALoglevelInfo Logs infos, warnings and errors.
	@constant		kSOMALoglevelDebug Debug log. Shouldn't be used at all, since it creates a lot of log messages.
	@availability	Available since iSoma 4.0 and later.
*/
typedef enum {
	kSOMALoglevelNone = 1 << 0,
    kSOMALoglevelError = 1 << 1,
	kSOMALoglevelWarning = 1 << 2,
    kSOMALoglevelInfo = 1 << 3,
    kSOMALoglevelDebug = 1 << 4
} SOMALogLevel;

/*!
	@class			SOMAGlobalSettings
	
	@abstract		Global Settings.
	@discussion		This class is designed to work with the [SOMAUserSettings] class. Use it to set the log level,
 the `userSettings` and whether location updates are enabled or not.
	@updated		2013-02-01
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAGlobalSettings : NSObject

/*!
	@property		userSettings
	@methodgroup    User & Global Settings

	@abstract       Returns the `SOMAUserSettings` object.
	@sa				SOMAUserSettings
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, retain) SOMAUserSettings* userSettings;

/*!
	@property		logLevel
	@methodgroup    User & Global Settings

	@abstract       Log level property. Default is `kSOMALoglevelNone`.
	@sa				SOMALogLevel
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic) SOMALogLevel logLevel;

/*!
	@property		locationUpdateEnabled
	@methodgroup    User & Global Settings

	@abstract       Defines whether location updates are enabled or not. Default is `NO`.
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, assign, readwrite) BOOL locationUpdateEnabled;

/*!
	@method			globalSettings
	@methodgroup    Other

	@abstract       Returns the shared `SOMAGlobalSettings` object.
	@discussion     Creates (if it hasn't been before) and returns the shared `SOMAGlobalSettings` object
 or nil if the object couldn't be created.
    @result         The shared `SOMAGlobalSettings` object.
    @availability	Available since iSoma 4.0 and later.
*/
+ (SOMAGlobalSettings*)globalSettings;

@end
