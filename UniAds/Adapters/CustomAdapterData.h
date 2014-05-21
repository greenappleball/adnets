//
//  CustomAdapterData.h
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "MPLogging.h"
#import <Foundation/Foundation.h>

#define vIdiom_phone        @"phone"
#define vIdiom_tablet       @"tablet"

#define vIsTestMode_yes     @"yes"

@interface CustomAdapterData : NSObject

@property(strong, nonatomic) NSString* idiom;
@property(strong, nonatomic) NSString* isTestMode;

+ (instancetype)dataWithInfo:(NSDictionary*)info;
- (void)setDataValue:(id)value forKey:(id)key;
- (BOOL)isTesting;
- (BOOL)isPhone;

@end
