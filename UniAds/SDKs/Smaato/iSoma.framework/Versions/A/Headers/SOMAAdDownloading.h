#pragma once

#import "SOMAAdSettings.h"
#import "SOMAUserSettings.h"

@protocol SOMAReceivedBanner;

/*!
	@protocol		SOMAAdDownloading
	
	@abstract		Ad Downloading Protocol.
	@discussion		The downloading protocol is designed to work with the `SOMAAdDownloader` class.
	@updated		2013-01-29
	@availability	Available since iSoma 4.0 and later.
*/
@protocol SOMAAdDownloading <NSObject>

/*!
	@method			init
	@methodgroup    Creating Instances

	@abstract       Returns the object implementing the `SOMAAdDownloading`.
    @result         The object implementing the protocol.
    @availability	Available since iSoma 4.0 and later.
*/
- (id)init;

/*!
	@method			asyncLoadNewBanner
	@methodgroup    Working with Ad Listeners

	@abstract       Asynchronously loads a new banner. Calls all ad listeners on success or failure.
	@discussion     Ad Listener is informed, either if banner loading was a success or a failure.
    @availability	Available since iSoma 4.0 and later.
	@sa				[SOMAAdListenerProtocol adDownloader:didReceiveBanner:]
	@sa				[SOMAAdListenerProtocol adDownloader:didFailWithError:]
*/
- (void)asyncLoadNewBanner;

/*!
	@method			asyncLoadNewBannerWithCompletionHandler:
	@methodgroup    Working with Ad Listeners

	@abstract       Asynchronously loads a new banner and invokes block when finished.
	@discussion     Instead of using notifications the return values will be dispatched to the completion block when the banner has been loaded.
	@param          receivedBanner The received banner.
	@param			error A NSError or nil if everything went fine.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)asyncLoadNewBannerWithCompletionHandler:(void (^)(id<SOMAReceivedBanner> receivedBanner, NSError *error))completionHandler;

/*!
	@method			setLocationUpdateEnabled:
	@methodgroup    Location Updates

	@abstract       Enables or disables the automatic location updates.
	@discussion     If enabled the location is updated every 60 seconds. Default is disabled.
	@param          updateEnabled A BOOL value indicating the desired update status.
    @availability	Available since iSoma 4.0 and later.
*/
-(void)setLocationUpdateEnabled:(BOOL)updateEnabled;

/*!
	@method			isLocationUpdateEnabled
	@methodgroup    Location Updates

	@abstract       Returns whether the automatic location update is enabled.
    @result         A BOOL indicating whether location update is enabled or not.
    @availability	Available since iSoma 4.0 and later.
*/
- (BOOL)isLocationUpdateEnabled;

/*!
	@method			adSettings
	@methodgroup    Setting and getting Ad Settings

	@abstract       Returns a `SOMAAdSettings` object.
    @result         A `SOMAAdSettings` object.
    @availability	Available since iSoma 4.0 and later.
	@see			SOMAAdSettings
*/
- (SOMAAdSettings*)adSettings;

/*!
	@method			setAdSettings:
	@methodgroup    Setting and getting Ad Settings

	@abstract       Replaces current ad settings with the passed object.
	@param          adSettings A `SOMAAdSettings` object.
    @availability	Available since iSoma 4.0 and later.
	@see			SOMAAdSettings
*/
- (void)setAdSettings:(SOMAAdSettings*)adSettings;

/*!
	@method			autoReloadEnabled
	@methodgroup    Automatic Reloading

	@abstract       Returns the whether automatic reloading is enabled or not.
    @result         Autoreloading as BOOL.
    @availability	Available since iSoma 4.0 and later.
	@see			-setAutoReloadEnabled:
*/
- (BOOL)autoReloadEnabled;

/*!
	@method			setAutoReloadEnabled:
	@methodgroup    Automatic Reloading

	@abstract       Enables or disables automatic reloading.
	@param          autoReloadEnabled A BOOL value indicating whether automatic reloading should be enabled or not.
    @availability	Available since iSoma 4.0 and later.
	@see			-autoReloadEnabled
*/
- (void)setAutoReloadEnabled:(BOOL)autoReloadEnabled;

/*!
	@method			autoReloadFrequency
	@methodgroup    Automatic Reloading

	@abstract       Returns the frequency of automatic reloading as integer value. Default is 60.
    @result         Automatic reloading frequency as integer value.
    @availability	Available since iSoma 4.0 and later.
*/
- (NSInteger)autoReloadFrequency;

/*!
	@method			setAutoReloadFrequency:
	@methodgroup    Automatic Reloading

	@abstract       Sets the automatic reloading frequency to the given value.
	@discussion     Updates the frequency to the given value.
 @note Minimum value is 30.
	@param          autoReloadFrequency The desired autoreload frequency as integer value.
    @availability	Available since iSoma 4.0 and later.
*/
- (void)setAutoReloadFrequency:(NSInteger)autoReloadFrequency;

@end


