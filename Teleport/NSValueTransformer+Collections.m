//
//  NSValueTransformer+Collections.m
//  Teleport
//
//  Created by Luca on 23/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+Collections.h"
#import "Teleport.h"

@implementation NSValueTransformer (Collections)

+(NSValueTransformer*)mutableArrayToArrayValueTansformer
{
    
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(id value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSMutableArray class]]);
        return [value copy];

    } reverseBlock:^id(id value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSArray class]]);
        return [value mutableCopy];
    }];
}

+(NSValueTransformer*)mutableSetToArrayValueTansformer
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(id value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSMutableSet class]]);
        return [value allObjects];
        
    } reverseBlock:^id(NSArray* value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSArray class]]);
        return [NSMutableSet setWithArray:value];
    }];
}

+(NSValueTransformer*)setToArrayValueTansformer
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(id value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSSet class]]);
        return [value allObjects];
        
    } reverseBlock:^id(NSArray* value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSArray class]]);
        return [NSSet setWithArray:value];
    }];
}

@end
