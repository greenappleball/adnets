//
//  MPAppLovinEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 6/17/13.
//
//

#import "MPAppLovinEventAdapter.h"
#import "MPLogging.h"

@interface MPAppLovinEventAdapter ()
@property (strong, nonatomic) ALAdView* applovinBannerView;
@end

@implementation MPAppLovinEventAdapter

#pragma mark - MPBannerCustomEvent Subclass Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting AppLovin banner...");
    
    if (CGSizeEqualToSize(size, MOPUB_BANNER_SIZE)) {
        self.applovinBannerView = [[ALAdView alloc] initBannerAd];
        self.applovinBannerView.adLoadDelegate = self;
        
        [self.applovinBannerView loadNextAd];
    }
    else
    {
        MPLogInfo(@"Failed to load AppLovin banner: ad size %@ is not supported.",
              NSStringFromCGSize(size));
        
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

#pragma mark -
#pragma mark ALAdLoadDelegate methods

-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    MPLogInfo(@"Successfully loaded AppLovin banner");
    
    [self.delegate bannerCustomEvent:self didLoadAd:self.applovinBannerView];
    
}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    MPLogInfo(@"Failed to load AppLovin banner: %i", code);
    
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
}

@end
