//
//  MPAppLovinInterstitialAdapter.h
//  
//
//  Created by Dmitri Petrishin on 6/17/13.
//
//

#import "MPInterstitialCustomEvent.h"
#import "ALInterstitialAd.h"
#import "ALAdService.h"


@interface MPAppLovinInterstitialAdapter : MPInterstitialCustomEvent <ALAdLoadDelegate, ALAdDisplayDelegate>

@end
