//
//  MBSBaseMediator.h
//  MBSAdSDK
//
//  Created by The Rubicon Project on 5/10/12.
//  Copyright (c) 2012 The Rubicon Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@protocol MBSBaseMediatorDelegate;
@interface MBSBaseMediator : NSObject
{
  id<MBSBaseMediatorDelegate> _mediationDelegate;  
}

@property (nonatomic,assign) id<MBSBaseMediatorDelegate> mediationDelegate;


-(id)initWithMediationDelegate:(id<MBSBaseMediatorDelegate>)delegate;

-(void)loadAd;
-(void)loadAdWithParams:(NSDictionary *)adParams;

-(void) unregisterDelegate;
-(void)rotatedToNewOrientation:(UIInterfaceOrientation)newOrientation;
-(void)stopLoadingAd;

@end
