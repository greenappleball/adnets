//
//  SOMAInterstitialBanner.h
//  iSoma
//
//  Created by Bilge Ulusoy on 6/6/13.
//
//

#import <UIKit/UIKit.h>
#import <iSoma/SOMAAdSettings.h>
#import <iSoma/SOMAAdDownloaderDelegate.h>

@class SOMAAdDownloader;

@protocol SOMAReceivedBanner;

/*!
	@class			SOMAInterstitialBannerView
	
	@abstract		Interstitial Banners.
	@discussion		Please ensure that you're setting your adpsace and publisher id before sending
 it to the App Store. `SOMAInterstitialBannerView` supports the following ad types:<br />
 <ul>
 <li><code>kSOMAAdTypeAll</code> All ad types will be received (default).</li>
 <li><code>kSOMAAdTypeText</code> Load text ads only.</li>
 <li><code>kSOMAAdTypeImage</code> Load image ads only.</li>
 <li><code>kSOMAAdTypeRichMedia</code> Load rich-media ads only.</li>
 <li><code>kSOMAAdTypeVideo</code> Load video ads only.</li>
 </ul>
 Find an example on how to create interstitial banner views below:
	- (void)viewDidLoad {
		SOMAInterstitialBannerView *interstitialBannerView = [[[SOMAInterstitialBannerView alloc] initWithPublisherID:0 adSpaceID:0] autorelease];
		// Ad Type
		interstitialBannerView.adType = kSOMAAdTypeAll;
		
		[interstitialBannerView asyncLoadInterstitialWithCompletionHandler:^(id<SOMAReceivedBanner> receivedBanner, NSError *error) {
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			
			if (error != nil) {
				NSLog(@"Error: %@", error);
			} else {
 			// Add Interstitial
				dispatch_async(dispatch_get_main_queue(), ^{
					[[[[UIApplication sharedApplication] delegate] window] addSubview:interstitialBannerView];
				});
			}
		}];

	}
 	@updated		2013-06-28
	@availability	Available since iSoma 4.0 and later.
*/

@interface SOMAInterstitialBannerView : UIView <SOMAAdDownloaderDelegate>

/*!
	@property		adType
	@methodgroup    Ad Formats

	@abstract       Ad type based on `SOMAAdType`. Default value is `kSOMAAdTypeAll`.
    @availability	Available since iSoma 6.0 and later.
*/
@property (assign, nonatomic, readwrite) SOMAAdType adType;


/*!
	@method			initWithPublisherID:adSpaceID:
	@methodgroup    Creating Interstitial Banners

	@abstract		Returns a newly created `SOMAInterstitialBannerView` object or nil if the object couldn't be created.
	@param			aPublisherID Publisher ID.
	@param			anAdSpaceID An AdSpace ID.
    @result         A newly created `SOMAInterstitialBannerView` object.
    @availability	Available since iSoma 6.0 and later.
*/
- (id)initWithPublisherID:(NSUInteger)aPublisherID adSpaceID:(NSUInteger)anAdSpaceID;

/*!
	@method			asyncLoadInterstitialWithCompletionHandler:
	@methodgroup    Loading Interstitials

	@abstract       Asynchronously loads a new interstitial banner and invokes block when finished.
	@param          receivedBanner The received banner.
	@param			error A NSError or nil if everything went fine.
    @availability	Available since iSoma 6.0 and later.
*/
- (void)asyncLoadInterstitialWithCompletionHandler:(void (^)(id<SOMAReceivedBanner> receivedBanner, NSError *error))completionHandler;

@end
