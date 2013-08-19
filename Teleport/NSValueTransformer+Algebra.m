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

+(NSValueTransformer*)arrayValueTansformer:(NSValueTransformer*)itemTransformer mutableCollection:(BOOL)mutableCollection
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSArray *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:values.count];
        for (NSInteger i=0; i<values.count; i++) {
            id value = values[i];
            [result addObject:[itemTransformer transformedValue:value]];
        }
        
        return [result copy];
        
    } reverseBlock:^id(NSArray *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:values.count];
        for (NSInteger i=0; i<values.count; i++) {
            id value = values[i];
            [result addObject:[itemTransformer reverseTransformedValue:value]];
        }
        
        return mutableCollection ? result : [result copy];
    }];
}

+(NSValueTransformer*)setValueTansformer:(NSValueTransformer*)itemTransformer mutableCollection:(BOOL)mutableCollection
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSSet *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSSet class]]);
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:values.count];
        
        [values each:^(id sender) {
            [result addObject:[itemTransformer transformedValue:sender]];
        }];
        
        return [result copy];
        
    } reverseBlock:^ id(NSArray *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        
        NSMutableSet *result = [NSMutableSet setWithCapacity:values.count];
        for (NSInteger i=0; i<values.count; i++) {
            id value = values[i];
            [result addObject:[itemTransformer reverseTransformedValue:value]];
        }
        
        return mutableCollection ? result : [result copy];
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
