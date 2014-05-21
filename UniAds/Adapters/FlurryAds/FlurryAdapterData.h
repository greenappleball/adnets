//
//  FlurryAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "CustomAdapterData.h"

#define SIZE_VIEW           UIUserInterfaceIdiomPad == [UIDevice currentDevice].userInterfaceIdiom ? MOPUB_LEADERBOARD_SIZE : MOPUB_BANNER_SIZE

@interface FlurryAdapterData : CustomAdapterData

@property(strong, nonatomic) NSString* adSpaceName;

@end
