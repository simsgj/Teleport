//
//  BPModel.m
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "BPModel.h"
#import "BlocksKit.h"
@implementation BPModel

+(id)modelsFromArray:(NSArray*)array
{
    return [array map:^id(id obj) {
        NSAssert([obj isKindOfClass:[NSDictionary class]], @"invalid input format");
        return [self modelFromDictionary:obj];
    }];
}

+(id)modelFromDictionary:(NSDictionary*)dictionary
{
    return [[[self class] alloc] initWithDictionary:dictionary];
}

#pragma mark -

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

-(id)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithDictionary:[aDecoder decodeObjectForKey:@"dictionary"]];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self dictionary] forKey:@"dictionary"];
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



-(NSDictionary*)dictionary
{
    return [self serialize];
}

#pragma mark -


-(void)deserialize:(NSDictionary*)dictionary
{
    [[self serializer] each:^(id key, id obj) {
        
        id value = [dictionary valueForKeyPath:obj];
        NSValueTransformer *transformer = [self transformers][key];
        
        if (value && ![value isEqual:[NSNull null]]) {
            
            if (transformer)
                value = [transformer reverseTransformedValue:value];
            
            [self setValue:value forKeyPath:key];
        }
    }];
    
}

-(NSDictionary*)serialize
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [[self serializer] each:^(id key, id obj) {
        
        NSDictionary *transformers = [self transformers];
        NSValueTransformer *transformer = transformers[key];
        id value = [self valueForKeyPath:key];
        
        if (value) {
            
            if (transformer)
                value = [transformer transformedValue:value];
            
            result[obj] = value;
        }
    }];
    
    return [result copy];
}

@end
