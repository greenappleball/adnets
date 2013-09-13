//
//  AdDownloader.h
//  SOMADemo
//
//  Created by Gerrit Alves on 30.06.11.
//  Copyright 2011 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMAAdDownloading.h"
#import "SOMAAdDownloaderDelegate.h"

@class SOMAAutoReloadTimer;
@protocol SOMAHTTPConnector;

/*!
	@class			SOMAAdDownloader
	
	@abstract		Ad downloader Class.
	@updated		2012-10-30
	@availability	Available since iSoma 4.0 and later.
*/
@interface SOMAAdDownloader : NSObject<SOMAAdDownloading> {
    id<SOMAHTTPConnector> mHttpConnector;
	id<SOMAAdDownloaderDelegate> mDelegate;
    NSString * mUserAgent;
    BOOL mDownloading;
    SOMAAutoReloadTimer *mReloadTimer;
}

/*!
	@property		adSettings
	@methodgroup	Ad Settings

	@abstract       Remote Ad Settings
    @availability	Available since iSoma 4.0 and later.
*/
@property (nonatomic, retain) SOMAAdSettings* adSettings;

/*!
	@property		delegate
	@methodgroup    Delegation

	@abstract       Ad Downloader's delegate.
    @availability	Available since iSoma 6.0 and later.
*/
@property (nonatomic, assign, readwrite) id<SOMAAdDownloaderDelegate> delegate;


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
