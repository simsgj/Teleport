//
//  NSValueTransformer+NSURL.m
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+NSURL.h"
#import "NSValueTransformerWithBlock.h"

@implementation NSValueTransformer (NSURL)


+(NSValueTransformer *)URLValueTansformer
{
    
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^ NSString* (NSURL *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSURL class]]);
        
        return [value absoluteString];
        
    } reverseBlock:^NSURL* (NSString *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSString class]]);
        
        return [NSURL URLWithString:value];
    }];
}

@end
