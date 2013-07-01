//
//  NSValueTransformer+BPModel.m
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+BPModel.h"
#import "NSValueTransformerWithBlock.h"
#import "BPModel.h"

@implementation NSValueTransformer (BPModel)

+(NSValueTransformer*)arrayValueTansformer:(NSValueTransformer*)itemTransformer
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSArray *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:values.count];
        for (NSInteger i=0; i<values.count; i++) {
            id value = values[i];
            [result addObject:[itemTransformer transformedValue:value]];
        }
        
        return result;
        
    } reverseBlock:^id(NSArray *values) {
        NSParameterAssert(values);
        NSParameterAssert([values isKindOfClass:[NSArray class]]);
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:values.count];
        for (NSInteger i=0; i<values.count; i++) {
            id value = values[i];
            [result addObject:[itemTransformer reverseTransformedValue:value]];
        }
        
        return result;
    }];
}

+(NSValueTransformer*)enumValueTansformer:(NSDictionary*)dictionary
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^ NSString* (NSNumber *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSNumber class]]);
        
        return dictionary[value];
        
    } reverseBlock:^NSNumber* (NSString *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSString class]]);
        
        return [dictionary allKeysForObject:value].lastObject;
    }];
}



+(NSValueTransformer*)modelValueTansformer:(Class)model
{
    NSParameterAssert([model isSubclassOfClass:[BPModel class]]);
    
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(BPModel *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:model]);
        
        return [value dictionary];
        
    } reverseBlock:^id(NSDictionary *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSDictionary class]]);
        
        return [model modelFromDictionary:value];
    }];
}

+(NSValueTransformer*)modelsValueTansformer:(Class)model
{
    return [self arrayValueTansformer:[self modelValueTansformer:model]];
}

@end
