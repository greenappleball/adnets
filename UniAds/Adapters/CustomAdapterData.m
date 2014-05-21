//
//  CustomAdapterData.m
//  Pods
//
//  Created by Dmitri Petrishin on 9/18/13.
//
//

#import "CustomAdapterData.h"

@implementation CustomAdapterData

#pragma mark - Private

- (void)mapWithInfo:(NSDictionary*)info
{
    __weak __typeof(&*self)weakSelf = self;
    [info enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [weakSelf setDataValue:obj forKey:key];
    }];
}

- (instancetype)initWithInfo:(NSDictionary*)info
{
    if (self = [super init]) {
        if ([info isKindOfClass:[NSDictionary class]]) {
            [self mapWithInfo:info];
        }
    }
    return self;
}

#pragma mark - Public

+ (instancetype)dataWithInfo:(NSDictionary *)info
{
    CustomAdapterData* response = [[[self class] alloc] initWithInfo:info];
    return response;
}

- (void)setDataValue:(id)value forKey:(id)key
{
    if ([self respondsToSelector:NSSelectorFromString(key)]) {
        [self setValue:value forKey:key];
    }
#ifdef DEBUG
    NSAssert([self respondsToSelector:NSSelectorFromString(key)], @"The %@ not support key: %@", [[self class] description], key);
#endif
}

- (BOOL)isTesting
{
    return [[self.isTestMode lowercaseString] isEqualToString:vIsTestMode_yes];
}

- (BOOL)isPhone
{
    NSString* idiom = [self.idiom lowercaseString];
    return (idiom && [idiom isEqualToString:vIdiom_phone]);
}

@end
