//
//  FlurryAdsWrapper.m
//  Pods
//
//  Created by Dmitri Petrishin on 10/10/13.
//
//

#import "FlurryAdsWrapper.h"

@interface FlurryAdsWrapper () <FlurryAdDelegate>
@property (strong, nonatomic) UIView* adView;
@property (strong, nonatomic) NSMutableDictionary* delegates;
@end

@implementation FlurryAdsWrapper

#pragma mark - accessors

- (NSMutableDictionary *)delegates
{
    if (nil == _delegates) {
        _delegates = [NSMutableDictionary new];
    }
    return _delegates;
}

- (UIView *)adView
{
    if (nil == _adView) {
        _adView = [UIView new];
    }
    return _adView;
}

- (void)beginWithDelegate:(id<FlurryAdDelegate>)delegate forAdSpace:(NSString*)space
{
#ifdef DEBUG
    NSAssert(space, @"Strongly need adSpace");
#endif
    if (space) {
        self.delegates[space] = delegate;
    }
}

#pragma mark - public

- (void)removeDelegate:(id<FlurryAdDelegate>)delegate
{
    NSArray* keys = [self.delegates allKeysForObject:delegate];
    [self.delegates removeObjectsForKeys:keys];
}

+ (UIView*)sharedAdView
{
    return [FlurryAdsWrapper sharedInstance].adView;
}

+ (instancetype)sharedInstance
{
    static FlurryAdsWrapper* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [FlurryAdsWrapper new];
        [FlurryAds setAdDelegate:_instance];
    });
    return _instance;
}

+ (void)fetchAdForSpace:(NSString*)space size:(FlurryAdSize)size withDelegate:(id<FlurryAdDelegate>)delegate
{
    [[FlurryAdsWrapper sharedInstance] beginWithDelegate:delegate forAdSpace:space];
    [FlurryAds fetchAdForSpace:space frame:CGRectZero size:size];
}

+ (void)displayAdSpace:(NSString*)space inView:(UIView *)viewContainer
{
    [FlurryAds displayAdForSpace:space onView:viewContainer];
}

+ (BOOL)adReadyForSpace:(NSString*)space
{
    return [FlurryAds adReadyForSpace:space];
}

+ (void)fetchAndDisplayAdForSpace:(NSString*)space size:(FlurryAdSize)size inView:(UIView *)viewContainer withDelegate:(id<FlurryAdDelegate>)delegate
{
    [[FlurryAdsWrapper sharedInstance] beginWithDelegate:delegate forAdSpace:space];
    [FlurryAds fetchAndDisplayAdForSpace:space view:viewContainer size:size];
}

#pragma mark - FlurryAdDelegate methods

- (void) spaceDidReceiveAd:(NSString*)adSpace
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceDidReceiveAd:)]) {
        [delegate spaceDidReceiveAd:adSpace];
    }
}

- (void) spaceDidFailToReceiveAd:(NSString*)adSpace error:(NSError *)error
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceDidFailToReceiveAd:error:)]) {
        [delegate spaceDidFailToReceiveAd:adSpace error:error];
    }
}

- (BOOL) spaceShouldDisplay:(NSString*)adSpace interstitial:(BOOL)interstitial
{
    BOOL isSpaceShouldDisplay = YES;
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceShouldDisplay:interstitial:)]) {
        isSpaceShouldDisplay = [delegate spaceShouldDisplay:adSpace interstitial:interstitial];
    }
    return isSpaceShouldDisplay;
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceDidDismiss:interstitial:)]) {
        [delegate spaceDidDismiss:adSpace interstitial:interstitial];
    }
}

- (void)spaceWillLeaveApplication:(NSString *)adSpace
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceWillLeaveApplication:)]) {
        [delegate spaceWillLeaveApplication:adSpace];
    }
}

- (void) spaceDidFailToRender:(NSString *)space error:(NSError *)error
{
    id <FlurryAdDelegate> delegate = self.delegates[space];
    if (delegate && [delegate respondsToSelector:@selector(spaceDidFailToRender:error:)]) {
        [delegate spaceDidFailToRender:space error:error];
    }
}

- (void)spaceWillDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceWillDismiss:interstitial:)]) {
        [delegate spaceWillDismiss:adSpace interstitial:interstitial];
    }
}

- (void) spaceWillExpand:(NSString *)adSpace
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceWillExpand:)]) {
        [delegate spaceWillExpand:adSpace];
    }
}

- (void) spaceWillCollapse:(NSString *)adSpace
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceWillCollapse:)]) {
        [delegate spaceWillCollapse:adSpace];
    }
}

- (void) spaceDidCollapse:(NSString *)adSpace
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceDidCollapse:)]) {
        [delegate spaceDidCollapse:adSpace];
    }
}

- (void) spaceDidReceiveClick:(NSString*)adSpace
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(spaceDidReceiveClick:)]) {
        [delegate spaceDidReceiveClick:adSpace];
    }
}

- (void)videoDidFinish:(NSString *)adSpace
{
    id <FlurryAdDelegate> delegate = self.delegates[adSpace];
    if (delegate && [delegate respondsToSelector:@selector(videoDidFinish:)]) {
        [delegate videoDidFinish:adSpace];
    }
}

@end
