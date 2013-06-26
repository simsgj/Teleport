//
//  BPModel.m
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "BPModel.h"
#import "NSDictionary+BlocksKit.h"

@implementation BPModel

- (id)init
{
    return [self initWithDictionary:@{}];
}

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    NSAssert([self class] != [BPModel class], @"this is an abstract class");
    dictionary = dictionary ? dictionary : @{};

    self = [super init];
    if (self) {
        [self deserialize:dictionary];
    }
    return self;
}

-(NSDictionary *)serializer
{
    NSAssert(YES, @"This method must not be called on the super class");
    return nil;
}

-(NSDictionary *)transformers
{
    NSAssert(YES, @"This method must not be called on the super class");
    return nil;
}

+(id)modelFromDictionary:(NSDictionary*)dictionary
{
    return [[[self class] alloc] initWithDictionary:dictionary];
}

-(NSDictionary*)dictionary
{
    return [self serialize];
}

#pragma mark -

-(void)deserialize:(NSDictionary*)dictionary
{
    [[self serializer] each:^(id key, id obj) {
        id value = dictionary[obj];
        NSValueTransformer *transformer = [self transformers][key];
        
        if (value && ![value isEqual:[NSNull null]]) {
            
            if (transformer)
                value = [transformer reverseTransformedValue:value];
            
            [self setValue:value forKey:key];
        }
    }];
}

-(NSDictionary*)serialize
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [[self serializer] each:^(id key, id obj) {
        
        NSDictionary *transformers = [self transformers];
        NSValueTransformer *transformer = transformers[key];
        if (transformer)
            result[obj] = [transformer transformedValue:[self valueForKey:key]];
        else
            result[obj] = [self valueForKey:key];
    }];
    
    return [result copy];
}

@end
