//
//  NSValueTransformer+Base64.m
//  Sneak Peek
//
//  Created by Luca on 6/26/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+Base64.h"
#import "NSValueTransformerWithBlock.h"

@implementation NSValueTransformer (Base64)


+(NSValueTransformer*)stringToBase64ValueTansformer
{
    return [NSValueTransformerWithBlock transformerWithBlock:^NSString* (NSString* string) {
        NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
        return [[self class] base64:data];
    }];
}
+(NSValueTransformer*)dataToBase64ValueTansformer
{
    return [NSValueTransformerWithBlock transformerWithBlock:^NSString* (NSData* data) {
        return [[self class] base64:data];
    }];
}


+(NSString*)base64:(NSData*)data
{
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
    
}
@end
