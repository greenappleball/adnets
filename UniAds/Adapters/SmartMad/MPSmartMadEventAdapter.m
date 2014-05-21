//
//  MPCustomEventAdapter.m
//  
//
//  Created by Dmitri Petrishin on 1/23/12.
//  Copyright (c) 2012 Postindustria. All rights reserved.
//

#import "MPSmartMadEventAdapter.h"
#import "SmartMadAdapterData.h"
#import "MPLogging.h"

@interface MPSmartMadEventAdapter () {
    SMAdBannerView* _adBannerView;
}

@property(strong, nonatomic) SmartMadAdapterData* params;

@end

#pragma mark - Implementation

@implementation MPSmartMadEventAdapter

- (void)dealloc {
    [self releaseBannerViewDelegateSafely];
    self.params = nil;
}

#pragma	mark - Private

- (NSError*) errorWithCode:(NSInteger)code userInfo:(NSDictionary*)info {
    NSDictionary* userInfo = [info isKindOfClass:[NSDictionary class]] ? info : [NSDictionary dictionary];
    return [NSError errorWithDomain:AD_DOMAIN code:code userInfo:userInfo];
}

- (void)releaseBannerViewDelegateSafely {
    [_adBannerView setDelegate:nil];
    _adBannerView = nil;
}

- (BOOL)is_iPhone
{
    return [self.params isPhone];
}

#pragma	mark - super

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    self.params = [SmartMadAdapterData dataWithInfo:info];
    [self loadSmartMadSDK];
}

#pragma	mark - SmartMad setup

- (void)setupSMAdManager
{
    [SMAdManager setAdRefreshInterval:[self adInterval]];
    [SMAdManager setApplicationId:[self adAppId]];
    BOOL isDebug = NO;
#ifdef DEBUG
    isDebug = YES;
#endif
    [SMAdManager setDebugMode:isDebug];
}

- (void)setupSMAdBannerWithSizeType:(SMAdBannerSizeType)sizeType
{
    _adBannerView = [[SMAdBannerView alloc] initWithAdSpaceId:[self adPositionId] smAdSize:sizeType];
    _adBannerView.rootViewController = [self.delegate viewControllerForPresentingModalView];
    _adBannerView.backgroundColor = [UIColor clearColor];
    [_adBannerView setDelegate:self];
}

#pragma	mark - Custom selector

- (void)loadSmartMadSDK
{
    // SmartMad id should set befor initing view
    [self setupSMAdManager];
    
    // init SmartMad's view
    SMAdBannerSizeType measureType = [self adMeasure];
    [self setupSMAdBannerWithSizeType:measureType];
}

#pragma	mark - SmartMadDelegate

-(NSString*)adAppId {
    return [self.params appId];
}

-(NSString*)adPositionId {
    return [self.params banner1];
}

-(NSTimeInterval)adInterval {
    // Default 60 Seconds
    NSTimeInterval timeInterval = 60;
#ifdef DEBUG
    timeInterval = 10;
#endif
    return timeInterval;
}

-(SMAdBannerSizeType)adMeasure{
    SMAdBannerSizeType result = PHONE_AD_BANNER_MEASURE_AUTO;
    if (![self is_iPhone]) {
        result = TABLET_AD_BANNER_MEASURE_728X90;
    }
    return result;
}

-(SMAdBannerAnimationType)adBannerAnimation {
    SMAdBannerAnimationType animationType = BANNER_ANIMATION_TYPE_NONE;
    return animationType;
}

#pragma SMAdBannerViewDelegate

- (void)adBannerViewDidReceiveAd:(SMAdBannerView*)adView{
    MPLogInfo(@"SmartMad has successfully loaded a new ad.");
    [self.delegate bannerCustomEvent:self didLoadAd:_adBannerView];
}

- (void)adBannerView:(SMAdBannerView*)adView didFailToReceiveAdWithError:(SMAdEventCode*)errorCode{
    MPLogInfo(@"SmartMad failed in trying to load or refresh an ad.");
    NSError* error = [self errorWithCode:errorCode.code userInfo:[NSDictionary dictionaryWithObject:@"Invalid Ad" forKey:@"userInfo"]];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)adBannerViewWillPresentScreen:(SMAdBannerView*)adView{
}

- (void)adBannerViewWillDismissScreen:(SMAdBannerView*)adView{
}

- (void)adBannerViewDidDismissScreen:(SMAdBannerView*)adView{
}

- (void)adBannerViewWillLeaveApplication:(SMAdBannerView*)adView{
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

- (void)adDidClick{
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)adWillExpandAd:(SMAdBannerView *)adView{
}

- (void)adDidCloseExpand:(SMAdBannerView*)adView{
}

- (void)appWillSuspendForAd:(SMAdBannerView*)adView{
}

- (void)appWillResumeFromAd:(SMAdBannerView*)adView{
}

@end
