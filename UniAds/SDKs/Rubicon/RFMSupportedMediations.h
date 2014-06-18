//
//  RFMSupportedMediations.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 2/26/13.
//  Copyright (c) 2013 Rubicon Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RFMSupportedMediations : NSObject{
  NSArray *_supportedMediations;
  NSDictionary *_mediationMap;
}


@property (nonatomic, retain) NSArray *supportedMediations;
@property (nonatomic, retain) NSDictionary *mediationMap;

+(RFMSupportedMediations *)sharedInstance;
-(Class)mediatorClassForMediationType:(NSString *)mediationType;
-(BOOL)isRFMMediationSupported:(NSString *)mediationType;

@end



