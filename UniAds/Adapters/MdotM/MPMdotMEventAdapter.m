//
//  MPMdotMEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 1/23/12.
//  Copyright (c) 2012 Postindustria. All rights reserved.
//

#import "MPMdotMEventAdapter.h"
#import "MdotMRequestParameters.h"
#import "MdotMAdapterData.h"
#import "MdotMAdSizes.h"
#import "MdotMAdView.h"
#import "MPLogging.h"

#pragma mark - Ad definitions

#define DEFAULT_FRAME (![self is_iPhone] ? BANNER_728_90 : BANNER_320_50)


@interface MPMdotMEventAdapter () <MdotMAdViewDelegate> {
    MdotMAdView* _adBannerView;
}

@property(retain, nonatomic) MdotMAdapterData* params;

@end


#pragma mark - Implementation

@implementation MPMdotMEventAdapter

- (void)dealloc {
    [self releaseBannerViewDelegateSafely];
}

#pragma	mark - Private

- (NSError*) errorWithCode:(NSInteger)code userInfo:(NSDictionary*)info {
    NSDictionary* userInfo = [info isKindOfClass:[NSDictionary class]] ? info : [NSDictionary dictionary];
    return [NSError errorWithDomain:AD_DOMAIN code:code userInfo:userInfo];
}

- (void)releaseBannerViewDelegateSafely {
    [_adBannerView setAdViewDelegate:nil];
    _adBannerView = nil;
}

#pragma	mark -

- (BOOL)is_iPhone
{
    return [self.params isPhone];
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = [MdotMAdapterData dataWithInfo:info];
    [self loadMdotMSDK];
}

#pragma	mark - MDotM

-(void) loadMdotMSDK
{
    _adBannerView = [[MdotMAdView alloc] initWithFrame:(CGRect){CGPointZero, DEFAULT_FRAME}];
    [_adBannerView setAdViewDelegate:self];

    MdotMRequestParameters* requestParameters = [[MdotMRequestParameters alloc] init];
    CLLocation* mLocation = [self.delegate location];
    if (mLocation) {
        requestParameters.longitude = mLocation.coordinate.longitude;
        requestParameters.latitude = mLocation.coordinate.latitude;
    }
    requestParameters.appKey = [self.params key];
    NSString *isDebug = @"0";
#ifdef DEBUG
    isDebug = @"1";
#endif
    requestParameters.test = isDebug;
    [_adBannerView loadBannerAd:requestParameters withSize:DEFAULT_FRAME];
}

#pragma	mark -  MdotMAdViewDelegate

-(void) onReceiveBannerAd
{
    MPLogInfo(@"MdotM has successfully loaded a new ad.");
    [self.delegate bannerCustomEvent:self didLoadAd:_adBannerView];
}

-(void) onReceiveBannerAdError:(NSString *)error
{
    MPLogInfo(@"MdotM failed in trying to load or refresh an ad. Error:<%@>",error);
    NSError* err = [self errorWithCode:1000 userInfo:@{@"userInfo":error}];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:err];
}

@end
