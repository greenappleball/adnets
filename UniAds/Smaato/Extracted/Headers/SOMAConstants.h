//
//  SOMAConstants.h
//  iSoma
//
//  Created by Bilge Ulusoy on 01.02.13.
//
//

#import <Foundation/Foundation.h>

/*!
	@constant		kSOMASDKVersion

	@abstract		SOMA SDK Version.
	@discussion		Defines the SDK Version.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMASDKVersion;

#pragma mark - Ad Downloader
/*!
	@constant		kSOMAAdDownloaderDidReceiveAdNotification

	@abstract		Ad Receive Notification.
	@discussion		Fired when a new Ad is ready and has been loaded.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDownloaderDidReceiveAdNotification;

/*!
	@constant		kSOMAAdDownloaderDidFailNotification

	@abstract		Ad Failure Notification.
	@discussion		Fired when an Error occured at loading an Ad.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDownloaderDidFailNotification;

/*!
	@constant		kSOMAAdDownloaderUserInfoDictionaryReceivedBannerKey

	@abstract		Notification User Info Dictionary Key.
	@discussion		Name of the Key which has been used to store the received Banner.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDownloaderUserInfoDictionaryReceivedBannerKey;

/*!
	@constant		kSOMAAdDownloaderUserInfoDictionaryErrorKey

	@abstract		Notification User Info Dictionary Key.
	@discussion		Name of the Key which has been used to store an Error.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDownloaderUserInfoDictionaryErrorKey;

#pragma mark - Soma Logger
/*!
	@constant		kSOMALoggerNewEntryNotification

	@abstract		New Log Entry Notification.
	@discussion		Fired when a new Log Entry has been posted.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMALoggerNewEntryNotification;

/*!
	@constant		kSOMALoggerNewEntryNotificationTypeDebug

	@abstract		Log Type.
	@discussion		Debug Log.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMALoggerNewEntryNotificationTypeDebug;

/*!
	@constant		kSOMALoggerNewEntryNotificationTypeError

	@abstract		Log Type.
	@discussion		Error log.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMALoggerNewEntryNotificationTypeError;

/*!
	@constant		kSOMALoggerNewEntryNotificationTypeWarning

	@abstract		Log Type.
	@discussion		Warning Log.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMALoggerNewEntryNotificationTypeWarning;

/*!
	@constant		kSOMALoggerNewEntryNotificationTypeInfo

	@abstract		Log Type.
	@discussion		Info Log.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMALoggerNewEntryNotificationTypeInfo;

/*!
	@constant		kSOMALoggerNewEntryNotificationUserInfoDictionaryMessageKey

	@abstract		Notification User Info Dictionary Key.
	@discussion		Name of the Key which has been used to store the Log Message.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMALoggerNewEntryNotificationUserInfoDictionaryMessageKey;

/*!
	@constant		kSOMALoggerNewEntryNotificationUserInfoDictionaryTypeKey

	@abstract		Notification User Info Dictionary Key.
	@discussion		Name of the Key which has been used to store the Log Type.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMALoggerNewEntryNotificationUserInfoDictionaryTypeKey;

#pragma mark - New Version

/*!
	@constant		kSOMANewVersionAvailableNotification

	@abstract		New Version Notification.
	@discussion		Fired when a new Version of iSoma is available.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMANewVersionAvailableNotification;

/*!
	@constant		kSOMANewVersionAvailableLogMessage

	@abstract		New Version.
	@discussion		New Version available.
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMANewVersionAvailableLogMessage;

#pragma mark - Ad Dimension Converter
/*!
	@constant		kSOMAAdDimensionMMA

	@abstract		MMA Ad Dimension.
	@discussion		MMA (320x50).
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDimensionMMA;

/*!
	@constant		kSOMAAdDimensionMEDRECT

	@abstract		Medium Rectangle Ad Dimension.
	@discussion		MedRect (300x250).
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDimensionMEDRECT;

/*!
	@constant		kSOMAAdDimensionLEADER

	@abstract		Leader Board Ad Dimension.
	@discussion		Leader Board (728x90)
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDimensionLEADER;

/*!
	@constant		kSOMAAdDimensionSKY

	@abstract		Sky Scraper Ad Dimension.
	@discussion		Sky Scraper (120x600).
    @availability	Available since iSoma 6.0 and later.
*/
extern __attribute__((visibility ("default"))) NSString *const kSOMAAdDimensionSKY;