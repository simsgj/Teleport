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
    return [self enumValueTansformer:dictionary fallBackTo:0 fallBackToValue:NO];
}

+(NSValueTransformer*)enumValueTansformer:(NSDictionary*)dictionary fallBackTo:(NSUInteger)fallback
{
    return [self enumValueTansformer:dictionary fallBackTo:fallback fallBackToValue:YES];
}

+(NSValueTransformer*)enumValueTansformer:(NSDictionary*)dictionary fallBackTo:(NSUInteger)fallback fallBackToValue:(BOOL)fallBackToValue
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^ NSString* (NSNumber *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSNumber class]]);
        
        return dictionary[value];
        
    } reverseBlock:^NSNumber* (NSString *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSString class]]);
        
        NSNumber *result =[dictionary allKeysForObject:value].lastObject;

        if (!result && fallBackToValue)
            result = @(fallback);

        NSAssert(result, @"impossibile to deserialize value with given dictionary");
        return result;
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

+(NSValueTransformer*)modelsValueTansformer:(Class)model withCollection:(Class)collection
{
    NSValueTransformer *eachValueTransformer = [NSValueTransformer eachValueTansformer:[self modelValueTansformer:model]];
    
    if ([collection isSubclassOfClass:[NSMutableArray class]])
        return [NSValueTransformer chainValueTansformers:@[[NSValueTransformer mutableArrayToArrayValueTansformer], eachValueTransformer]];
    else if ([collection isSubclassOfClass:[NSMutableSet class]])
        return [NSValueTransformer chainValueTansformers:@[[NSValueTransformer mutableSetToArrayValueTansformer], eachValueTransformer]];
    else if ([collection isSubclassOfClass:[NSArray class]])
        return eachValueTransformer;
    else if ([collection isSubclassOfClass:[NSSet class]])
        return [NSValueTransformer chainValueTansformers:@[[NSValueTransformer setToArrayValueTansformer], eachValueTransformer]];
    else {
        NSAssert(YES, @"collection not valid (%@)", NSStringFromClass(collection));
        return nil;
    } 
}

+(NSValueTransformer*)modelsValueTansformer:(Class)model
{
    return [self modelsValueTansformer:model withCollection:[NSArray class]];
}

@end
