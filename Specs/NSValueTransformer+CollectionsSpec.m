//
//  NSValueTransformer+AlgebraSpec.m
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "Kiwi.h"
#import "Teleport.h"

SPEC_BEGIN(NSValueTransformer_CollectionsSpec)

describe(@"NSValueTransformer+Collections", ^{
    
    
    it(@"should allow to transform collection (Array - mutable)", ^{
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];
        
        NSValueTransformer *eachValueTransformer = [NSValueTransformer eachValueTansformer:prefixTransformer];
        NSValueTransformer *mutableArrayTransformer =  [NSValueTransformer chainValueTansformers:@[[NSValueTransformer mutableArrayToArrayValueTansformer], eachValueTransformer]];
        
        NSMutableArray *values = [@[@"A", @"B", @"C"]  mutableCopy];
        NSArray *expectedTransformedValue = @[@"_A", @"_B", @"_C"];
        
        NSArray *transformedValue = [mutableArrayTransformer transformedValue:values];
        NSArray *reverseTransformedValue  = [mutableArrayTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        [[reverseTransformedValue should] equal:values];
        
        [[transformedValue should] beKindOfClass:[NSArray class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableArray class]];
        [[reverseTransformedValue should] beKindOfClass:[NSArray class]];
        [[reverseTransformedValue should] beKindOfClass:[NSMutableArray class]];
    });
    
    it(@"should allow to transform collection (Set)", ^{
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];
        
        NSValueTransformer *eachValueTransformer = [NSValueTransformer eachValueTansformer:prefixTransformer];
        NSValueTransformer *setTransformer =  [NSValueTransformer chainValueTansformers:@[[NSValueTransformer setToArrayValueTansformer], eachValueTransformer]];
        
        NSSet *values = [NSSet setWithArray:@[@"A", @"B", @"C"]];
        NSArray *expectedTransformedValue = @[@"_A", @"_B", @"_C"];
        
        NSArray *transformedValue = [setTransformer transformedValue:values];
        NSSet *reverseTransformedValue  = [setTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        [[reverseTransformedValue should] equal:values];
        
        [[transformedValue should] beKindOfClass:[NSArray class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableArray class]];
        [[reverseTransformedValue should] beKindOfClass:[NSSet class]];
        [[reverseTransformedValue shouldNot] beKindOfClass:[NSMutableSet class]];
        
    });
    
    
    
    it(@"should allow to transform collection (Set - mutable)", ^{
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];
        
        NSValueTransformer *eachValueTransformer = [NSValueTransformer eachValueTansformer:prefixTransformer];
        NSValueTransformer *setTransformer =  [NSValueTransformer chainValueTansformers:@[[NSValueTransformer mutableSetToArrayValueTansformer], eachValueTransformer]];
        
        
        NSMutableSet *values = [NSMutableSet setWithArray:@[@"A", @"B", @"C"]];
        NSArray *expectedTransformedValue = @[@"_A", @"_B", @"_C"];
        
        NSArray *transformedValue = [setTransformer transformedValue:values];
        NSSet *reverseTransformedValue  = [setTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        [[reverseTransformedValue should] equal:values];
        
        [[transformedValue should] beKindOfClass:[NSArray class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableArray class]];
        [[reverseTransformedValue should] beKindOfClass:[NSSet class]];
        [[reverseTransformedValue should] beKindOfClass:[NSMutableSet class]];
        
    });

});

SPEC_END