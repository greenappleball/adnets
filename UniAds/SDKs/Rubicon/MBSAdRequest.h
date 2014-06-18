//
//  MBSAdRequest.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 1/14/13.
//  Copyright (c) 2013 The Rubicon Project Inc. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MBSAdRequest : NSObject
{
  NSString *_rfmAdServer;
  NSString *_rfmAdPublisherId;
  NSString *_rfmAdAppId;
  
  //Optional targeting info for ad request
  NSDictionary *_targetingInfo;
  
  
  // The following paramters, if set, provide extra information
  // for the ad request. If you happen to have this information, providing it will
  // help select better targeted ads and will improve monetization.
  
  
  // If your application uses CoreLocation you can provide the current coordinates
  // to help MBSAd,
  //
  // For example:
  //    myMBSAdRequest.locationLatitude = myCLLocationManager.location.coordinate.latitude;
  //    myMBSAdRequest.locationLongitude = myCLLocationManager.location.coordinate.longitude;
  
  //user location latitude as obtained from core location.
  double _locationLatitude;
  //user location longitude as obtained from core location.
  double _locationLongitude;
  
  //Optional : Set string @"ip" for allowing ip based location detection.
  NSString *_allowLocationDetectType;
  

  //These optional parameters allow set additional adview configuration parameters
  
  //When the ad is in landing view mode, set the transparency with which
  //your background application is visible along the edges and corners of the landing
  //view. The default value for this setting is 0.6.
  CGFloat _landingViewAlpha;

  //These optional parameters should be implemented only during testing phase
  
  //This optional parameter specifies the mode in which requests are
  //handled. The current supported values are as follows –
  //“test” – Test Mode, impressions are not counted
  NSString *_rfmAdMode;
  
  //This optional parameter only renders a specific ad.
  //This setting should only be implemented for test accounts
  //while testing the performance of a particular ad.
  //Return @"0" if you want this setting to be ignored by the SDK
  NSString *_rfmAdTestAdId;
  
  NSString *_rfmAdType;
  //Default = NO. Set YES if you want ad request URL to be printed on console.
  BOOL _showDebugLogs;
}

@property (nonatomic, retain) NSString *rfmAdServer;
@property (nonatomic, retain) NSString *rfmAdPublisherId;
@property (nonatomic, retain) NSString *rfmAdAppId;
@property (nonatomic, retain) NSDictionary *targetingInfo;
@property (assign) double locationLatitude;
@property (assign) double locationLongitude;
@property (assign) CGFloat landingViewAlpha;

@property (nonatomic, retain) NSString *allowLocationDetectType;
@property (nonatomic, retain) NSString *rfmAdMode;
@property (nonatomic, retain) NSString *rfmAdTestAdId;
@property (assign) BOOL showDebugLogs;

@property (nonatomic, retain) NSString *rfmAdType;


- (id)initRequestWithServer:(NSString *)adServer
                   andAppId:(NSString *)appId
                   andPubId:(NSString *)pubId;

@end
