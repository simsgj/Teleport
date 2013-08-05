//
//  NSValueTransformer+BPModel.m
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+BPModel.h"
#import "Teleport.h"

@implementation NSValueTransformer (BPModel)



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
    return [NSValueTransformer arrayValueTansformer:[self modelValueTansformer:model]];
}

@end
