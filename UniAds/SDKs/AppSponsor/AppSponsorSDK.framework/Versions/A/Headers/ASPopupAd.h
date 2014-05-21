//
//  ASPopupAd.h
//  AppSponsorSDKFramework
//
//  Created by frank wang on 3/31/14.
//  Copyright (c) 2014 manage. All rights reserved.
//
#define AS_SDK_VERSION                 @"3.0.1"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ASPopupAdDelegate <NSObject>
-(void)popoverWillAppear;
-(void)popoverWillDisappear:(NSString*)reason;
@optional
-(void)didCacheInterstitial;
-(void)popoverDidFailToLoadWithError:(NSError*)error;
-(void)onRewardedAdFinished;
@end

typedef enum { AS_MALE = 1, AS_FEMALE = 2, AS_OTHER = 3 } Gender;

@interface ASPopupAd : NSObject
@property (nonatomic, strong) NSString *zoneId;
@property (nonatomic) UIViewController *parentController;
@property (nonatomic, weak) id<ASPopupAdDelegate> delegate;
//test mode is to force to show AppSponsor AD
@property (nonatomic, assign) BOOL testMode;
@property (nonatomic, assign) BOOL interstitialView;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *metro;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, assign) Gender *gender;
@property (nonatomic, strong) NSString *yob;
@property (nonatomic, strong) NSString *u_country;
@property (nonatomic, strong) NSString *u_city;
@property (nonatomic, strong) NSString *u_zip;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *pub_uid; //user id within publisher app


-(ASPopupAd*)enableLocationSupport;
-(ASPopupAd*)initWithZoneId:(NSString*)adId;
-(ASPopupAd*)initRewardedAdWithZoneId:(NSString*)adId andUserID:(NSString*)uid;

/*
 * Preloads the ad.
 */
-(void)load;

/*
 * Presents the ad onto the current top ViewController
 * When ad is done being presented (closed), the ad is destroyed.
 * Load will need to be called to recreate the destroyed ad.
 */
-(void)presentAd;

/*
 * Check to see whether ad is ready to display
 */
-(BOOL)isReady;

/*
 * Return percentage of video ad played
 */
-(int)rewardedAdStatus;


@end
