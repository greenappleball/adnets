//
//  AmazonAdError.h
//  AmazonMobileAdsSDK
//
//  Copyright (c) 2012-2013 Amazon.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    InvalidRequestErrorCode,    // Invalid Request. Example : "Invalid application Id".
    OsVersionTooLowErrorCode,   // OS version is too low Example: < 4.x
    InternalServerErrorCode,    // Internal server error. Example : "Ad not found".
    NetworkConnectionErrorCode  // Network Connection error
} AmazonAdErrorCode;

@interface AmazonAdError : NSObject

@property (nonatomic, readonly) AmazonAdErrorCode errorCode;
@property (nonatomic, strong, readonly) NSString *errorDescription; 

@end
