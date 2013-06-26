#import <Foundation/Foundation.h>

@interface NSDate(Milliseconds)

-(NSString*)millisecondsSince1970;

+(NSDate*) dateWithMillisecondsSince1970:(NSString*)string;

@end
