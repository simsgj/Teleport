//
//  NSValueTransformer+Algebra.m
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+Algebra.h"
#import "Teleport.h"
#import "BlocksKit.h"

@implementation NSValueTransformer (Algebra)

+(NSValueTransformer*)eachValueTansformer:(NSValueTransformer*)itemTransformer
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSArray *values) {
        NSParameterAssert(values);
        NSValueTransformer *transformer = [values isKindOfClass:[NSArray class]] ?
                    [[self class] eachArrayValueTansformer:itemTransformer] :
                    [[self class] eachDictionaryValueTansformer:itemTransformer];
        
        return [transformer transformedValue:values];
        
    } reverseBlock:^id(NSArray *values) {
        
        NSValueTransformer *transformer = [values isKindOfClass:[NSArray class]] ?
                [[self class] eachArrayValueTansformer:itemTransformer] :
                [[self class] eachDictionaryValueTansformer:itemTransformer];
        
        return [transformer reverseTransformedValue:values];
    }];
}

+(NSValueTransformer*)eachArrayValueTansformer:(NSValueTransformer*)itemTransformer{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSArray *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:values.count];
        for (NSInteger i=0; i<values.count; i++) {
            id value = values[i];
            [result addObject:[itemTransformer transformedValue:value]];
        }
        BOOL mutable = [values isKindOfClass:[NSMutableArray class]];
        return mutable ? result : [result copy];
        
    } reverseBlock:^id(NSArray *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:values.count];
        for (NSInteger i=0; i<values.count; i++) {
            id value = values[i];
            [result addObject:[itemTransformer reverseTransformedValue:value]];
        }
        
        BOOL mutable = [values isKindOfClass:[NSMutableArray class]];
        return mutable ? result : [result copy];
    }];
}

+(NSValueTransformer*)eachDictionaryValueTansformer:(NSValueTransformer*)itemTransformer
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSDictionary *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSDictionary class]]);
        
        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
        [values each:^(id key, id obj) {
            result[key] = [itemTransformer transformedValue:obj];
        }];
        
        BOOL mutable = [values isKindOfClass:[NSMutableDictionary class]];
        return mutable ? result : [result copy];
        
    } reverseBlock:^id(NSDictionary *values) {
        
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSDictionary class]]);
        
        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
        [values each:^(id key, id obj) {
            result[key] = [itemTransformer reverseTransformedValue:obj];
        }];
        
        BOOL mutable = [values isKindOfClass:[NSMutableDictionary class]];
        return mutable ? result : [result copy];
        
    }];
}

+(NSValueTransformer*)chainValueTansformers:(NSArray*)transformers
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(id value) {
        __block id result = value;
        [transformers enumerateObjectsUsingBlock:^(NSValueTransformer *obj, NSUInteger idx, BOOL *stop) {
            result = [obj transformedValue:result];
        }];
        return result;
        
    } reverseBlock:^id(id value) {
        __block id result = value;
        [transformers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            result = [obj reverseTransformedValue:result];
        }];
        
        return result;
    }];
}
@end
