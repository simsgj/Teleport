#import <Foundation/Foundation.h>

@interface NSValueTransformer(NSDateMilliseconds)
+(NSValueTransformer*)dateToMillisecondsStringValueTansformer;
+(NSValueTransformer*)dateToMillisecondsValueTansformer;

@end
