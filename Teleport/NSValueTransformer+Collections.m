//
//  NSValueTransformer+Collections.m
//  Teleport
//
//  Created by Luca on 23/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+Collections.h"
#import "Teleport.h"
#import "BlocksKit.h"

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
    return [[self class] setToArrayValueTansformerMutable:YES];
    
}

+(NSValueTransformer*)setToArrayValueTansformer
{
    return [[self class] setToArrayValueTansformerMutable:NO];
}

+(NSValueTransformer*)setToArrayValueTansformerMutable:(BOOL)mutable
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(id value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSSet class]]);
        return [value allObjects];
        
    } reverseBlock:^id(NSArray* value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSArray class]]);
        return mutable ? [NSMutableSet setWithArray:value] : [NSSet setWithArray:value];
    }];
}

+(NSValueTransformer*)dictionaryToArrayValueTansformerWithIndex:(NSString*)index
{
    return [[self class] dictionaryToArrayValueTansformerWithIndex:index mutable:NO];
}

+(NSValueTransformer*)mutableDictionaryToArrayValueTansformerWithIndex:(NSString*)index
{
    return [[self class] dictionaryToArrayValueTansformerWithIndex:index mutable:YES];
}


+(NSValueTransformer*)dictionaryToArrayValueTansformerWithIndex:(NSString*)index mutable:(BOOL)mutable
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSDictionary* value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSDictionary class]]);
        return [value allValues];
        
    } reverseBlock:^id(NSArray* values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:values.count];
        
        [values bk_each:^(id sender) {
            id key = [sender valueForKey:index];
            [dictionary setValue:sender forKey:key];
        }];
        
        return mutable ? dictionary : [dictionary copy];
    }];
    
}

+(NSValueTransformer*)mutableDictionaryToDictionaryValueTansformer
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^NSDictionary *(NSMutableDictionary* value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSMutableDictionary class]]);
        return [value copy];
        
    } reverseBlock:^NSMutableDictionary *(NSDictionary* value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSDictionary class]]);
        return [value mutableCopy];
    }];
}

@end
