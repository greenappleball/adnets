/*!
 @header SMAdBannerView.h
 @abstract base bannerView
 @author madhouse
 @version 3.0.4 2013/08/14 Creation 
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SMAdManager.h"



@class SMAdBannerView;
@class SMAdEventCode;


/*!
 @protocol
 @abstract SMAdBannerViewDelegate
 @discussion SMAdBannerView's delegate
 */

@protocol SMAdBannerViewDelegate <NSObject>

@optional

/*!
 @method
 @abstract 旗帜广告接收成功
 @discussion
 @param adView
 @result nil
 */
- (void)adBannerViewDidReceiveAd:(SMAdBannerView*)adView;

/*!
 @method
 @abstract 旗帜广告接收失败
 @discussion
 @param adView
 @param errorCode
 @result nil
 */
- (void)adBannerView:(SMAdBannerView*)adView didFailToReceiveAdWithError:(SMAdEventCode*)errorCode;

/*!
 @method
 @abstract 旗帜广告将要添加到屏幕上
 @discussion
 @param adView
 @param eventCode
 @result nil
 */
- (void)adBannerViewWillPresentScreen:(SMAdBannerView*)adView impressionEventCode:(SMAdEventCode*)eventCode;

/*!
 @method
 @abstract 旗帜广告将要从屏幕上移出
 @discussion
 @param adView
 @result nil
 */
- (void)adBannerViewWillDismissScreen:(SMAdBannerView*)adView;

/*!
 @method
 @abstract 旗帜广告已经从屏幕上移出
 @discussion
 @param adView
 @result nil
 */
- (void)adBannerViewDidDismissScreen:(SMAdBannerView*)adView;

/*!
 @method
 @abstract 旗帜广告被点击后应用切换到后台，例如：调用系统浏览器
 @discussion
 @param adView
 @result nil
 */
- (void)adBannerViewWillLeaveApplication:(SMAdBannerView*)adView;

/*!
 @method
 @abstract 旗帜广告广告已经被点击
 @discussion
 @result nil
 */
- (void)adDidClick;

/*!
 @method
 @abstract 旗帜广告将要被扩展
 @discussion
 @param adView
 @result nil
 */
- (void)adWillExpandAd:(SMAdBannerView *)adView;

/*!
 @method
 @abstract 旗帜广告已经关闭扩展
 @discussion
 @param adView
 @result nil
 */
- (void)adDidCloseExpand:(SMAdBannerView*)adView;

/*!
 @method
 @abstract 应用将被旗帜广告遮挡，例如：调用内置浏览器或全屏广告
 @discussion
 @param adView
 @result nil
 */
- (void)appWillSuspendForAd:(SMAdBannerView*)adView;

/*!
 @method
 @abstract 应用将从被广告遮挡状态恢复
 @discussion
 @param adView
 @result nil
 */
- (void)appWillResumeFromAd:(SMAdBannerView*)adView;

@end


/*!
 @class
 @abstract SMAdBannerView
 */

@interface SMAdBannerView : UIView

/*!
 @property
 @abstract SMAdBannerViewDelegate's object
 */
@property (nonatomic, assign) id<SMAdBannerViewDelegate> delegate;

/*!
 @property
 @abstract adSpaceId
 */

@property (nonatomic, copy) NSString* adSpaceId;

/*!
 @property
 @abstract adSize
 */
@property (nonatomic, assign) SMAdBannerSizeType adSize;

/*!
 @property
 @abstract rootViewController
 */
@property (nonatomic, assign) UIViewController *rootViewController;

/*!
 @property
 @abstract adBannerAnimationType
 */
@property (nonatomic, assign) SMAdBannerAnimationType adBannerAnimationType;

/*!
 @method
 @abstract SMAdBannerView初始化方法
 @discussion 
 @param adSpaceId 

 @result SMAdBannerView's object
 */

- (id)initWithAdSpaceId:(NSString*)adSpaceId;


/*!
 @method
 @abstract SMAdBannerView初始化方法
 @discussion 
 @param adSpaceId
 @param adSize
 @result SMAdBannerView's object
 */
- (id)initWithAdSpaceId:(NSString *)adSpaceId smAdSize:(SMAdBannerSizeType)adSize;

@end
