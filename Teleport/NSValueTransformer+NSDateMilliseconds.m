#import "NSValueTransformer+NSDateMilliseconds.h"
#import "Teleport.h"

@interface NSDate (Milliseconds)
-(NSString*)millisecondsSince1970;
+(NSDate*) dateWithMillisecondsSince1970:(NSString*)string;
@end

@implementation NSDate (Milliseconds)

-(NSString*)millisecondsSince1970
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"SSS"];
    
    NSString *milliseconds = [dateFormatter stringFromDate:self];
    NSInteger seconds = [self timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%d%@", seconds, milliseconds];
}

-(NSString*)millisecondsFromNow
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"SSS"];
    
    NSString *milliseconds = [dateFormatter stringFromDate:self];
    NSInteger seconds = [self timeIntervalSinceNow];
    
    return [NSString stringWithFormat:@"%d%@", seconds, milliseconds];
}

+(NSDate*) dateWithMillisecondsSince1970:(NSString*)string
{
    
    long long timestamp = [string longLongValue];
    long long seconds = timestamp/1000;
    long long milliseconds = timestamp - (seconds*1000);
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    if (milliseconds>0)
        date = [date dateByAddingTimeInterval:(milliseconds / 1000.0f)];
    
    return date;
}

+(NSDate*) dateWithMillisecondsFromNow:(NSString*)string
{
    
    long long timestamp = [string longLongValue];
    long long seconds = timestamp/1000;
    long long milliseconds = timestamp - (seconds*1000);
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    if (milliseconds>0)
        date = [date dateByAddingTimeInterval:(milliseconds / 1000.0f)];
    
    return date;
}

@end

@implementation NSValueTransformer(NSDateMilliseconds)

+(NSValueTransformer *)dateToMillisecondsStringValueTansformer
{
    
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^ NSString* (NSDate *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSDate class]]);
        
        return [value millisecondsSince1970];
        
    } reverseBlock:^NSDate* (NSString *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSString class]]);
        
        return [NSDate dateWithMillisecondsSince1970:value];
    }];
}

+(NSValueTransformer *)dateToMillisecondsFromNowStringValueTansformer
{
    
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^ NSString* (NSDate *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSDate class]]);
        
        return [value millisecondsSince1970];
        
    } reverseBlock:^NSDate* (NSString *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSString class]]);
        
        return [NSDate dateWithMillisecondsSince1970:value];
    }];
}

+(NSValueTransformer*)dateToMillisecondsValueTansformer
{
    return [NSValueTransformer chainValueTansformers:@[[NSValueTransformer dateToMillisecondsStringValueTansformer],
                                                       [NSValueTransformer stringToNumberValueTansformer:NSNumberFormatterDecimalStyle]]];
}

+(NSValueTransformer *)dateToMillisecondsFromNowValueTansformer
{
    return [NSValueTransformer chainValueTansformers:@[[NSValueTransformer dateToMillisecondsFromNowStringValueTansformer],
                                                       [NSValueTransformer stringToNumberValueTansformer:NSNumberFormatterDecimalStyle]]];}

@end
