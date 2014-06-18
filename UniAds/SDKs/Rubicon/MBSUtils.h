//
//  MBSUtils.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 5/14/12.
//  Copyright (c) 2012 The Rubicon Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MRP_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//Status enums for the AdView
typedef enum
{
  AD_INIT,
  AD_BANNER_REQUESTED,
  AD_BANNER_DISPLAYED,
  AD_LANDING_DISPLAYED,
  AD_MODAL_LANDING_DISPLAYED,
  AD_INTERSTITIAL_REQUESTED,
  AD_INTERSTITIAL_DISPLAYED,
  AD_READY_TO_DISPLAY
}adLoadingStatusTypes;

#define kAdParamsAdFrameKey @"adFrame"
#define kAdParamsAdContentKey @"rspData"
#define kAdParamsCreativeApiKey @"creativeApiType"
#define kAdParamsBaseUrlKey @"adurl"
#define kAdParamsAdContentTypeKey @"adContentType"
#define kAdParamsAdPreCacheKey @"shouldPrecache"

#define kAdContentTypeHtml @"html"
#define kAdContentTypeJson @"json"
#define kAdContentTypeJavascript @"js"


//Mediation Names
#define kMediationTypeRfm @"rfm"
#define kMediationTypeMraid @"MRAID"
#define kMediationTypeRfmCaching @"cache"
//Third party mediations
#define kMediationTypeAdmob @"adm"
#define kMediationTypeDFP   @"dfp"
#define kMediationTypeiAd   @"iAd"

//Mediation class names
#define kMediationClassNameRfm @"MBSApiMediator"
#define kMediationClassNameMraid @"MraidApiMediator"
#define kMediationClassNameRfmCaching @"MBSCachingMediator"


id getJSONObjectForData(NSData *inputData);

BOOL isAdInInit(adLoadingStatusTypes status);
BOOL isAdReadyForRequest(adLoadingStatusTypes status);
BOOL isWaitingForAd(adLoadingStatusTypes status);
BOOL isAdInBannerView(adLoadingStatusTypes status);
BOOL isAdInInterstitialView(adLoadingStatusTypes status);
BOOL isAdInLandingView(adLoadingStatusTypes status);
BOOL isAdInModalLandingView(adLoadingStatusTypes status);
BOOL isAdTypeInterstitial(NSString *adType);
BOOL isAdReadyToDisplay(adLoadingStatusTypes status);

void setInterfaceOrientation(UIInterfaceOrientation orientation);
UIInterfaceOrientation getInterfaceOrientation(void);
