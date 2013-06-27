//
//  ALAdUpdateDelegate.h
//  sdk
//
//  Created by David Anderson on 10/1/12.
//
//

#import <Foundation/Foundation.h>

@protocol ALAdUpdateObserver <NSObject>

-(void)adService:(ALAdService *)adService didUpdateAd:(ALAd *)ad;

/**
 * Check if this delegate currently accepts ad updates
 */
-(BOOL)canAcceptUpdate;

@end
