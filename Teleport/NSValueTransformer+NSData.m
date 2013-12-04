//
//  NSValueTransformer+NSData.m
//  Teleport
//
//  Created by Luca on 04/12/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+NSData.h"
#import "Teleport.h"

@implementation NSValueTransformer (NSData)

+(NSValueTransformer *)dataToBase64StringTansformer
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^NSString* (NSData *value) {

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        if ([value respondsToSelector:@selector(base64EncodedStringWithOptions:)])
            return [value base64EncodedStringWithOptions:0];
        else if ([value respondsToSelector:@selector(base64Encoding)])
            return [value base64Encoding];
        else
            return nil;
#pragma GCC diagnostic warning "-Wdeprecated-declarations"

        
    } reverseBlock:^NSData *(NSString * value) {
        
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        if ([[NSData alloc] respondsToSelector:@selector(initWithBase64EncodedString:options:)])
            return [[NSData alloc] initWithBase64EncodedString:value options:0];
        else if ([[NSData alloc] respondsToSelector:@selector(initWithBase64Encoding:)])
            return [[NSData alloc] initWithBase64Encoding:value];
        else
            return nil;
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
        
    }];
}
@end
