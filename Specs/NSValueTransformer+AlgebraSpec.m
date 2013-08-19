//
//  NSValueTransformer+AlgebraSpec.m
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "Kiwi.h"
#import "Teleport.h"

SPEC_BEGIN(NSValueTransformer_AlgebraSpec)

describe(@"NSValueTransformer+Algebra", ^{
    
    it(@"should allow to chain transformation", ^{
        NSValueTransformer *suffixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"%@_", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(0, value.length-1)];
        }];
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];

        
        NSValueTransformer *chain = [NSValueTransformer chainValueTansformers:@[suffixTransformer, prefixTransformer]];
        
        NSString *a = @"A";
        NSString *c = @"_A_";
        
        [[[chain transformedValue:a] should] equal:c];
        [[[chain reverseTransformedValue:c] should] equal:a];

        
    });
    
    it(@"should allow to transform collection (Array)", ^{
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];
        
        NSValueTransformer *arrayTransformer = [NSValueTransformer arrayValueTansformer:prefixTransformer mutableCollection:NO];
        
        NSArray *values = @[@"A", @"B", @"C"];
        NSArray *expectedTransformedValue = @[@"_A", @"_B", @"_C"];
        
        NSArray *transformedValue = [arrayTransformer transformedValue:values];
        NSArray *reverseTransformedValue  = [arrayTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        [[reverseTransformedValue should] equal:values];

        [[transformedValue should] beKindOfClass:[NSArray class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableArray class]];
        [[reverseTransformedValue should] beKindOfClass:[NSArray class]];
        [[reverseTransformedValue shouldNot] beKindOfClass:[NSMutableArray class]];


    });
    
    it(@"should allow to transform collection (Array - mutable)", ^{
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];
        
        NSValueTransformer *mutableArrayTransformer = [NSValueTransformer arrayValueTansformer:prefixTransformer mutableCollection:YES];
        
        NSArray *values = @[@"A", @"B", @"C"];
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
        
        NSValueTransformer *setTransformer = [NSValueTransformer setValueTansformer:prefixTransformer mutableCollection:NO];
        
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
        
        NSValueTransformer *setTransformer = [NSValueTransformer setValueTansformer:prefixTransformer mutableCollection:YES];
        
        NSSet *values = [NSSet setWithArray:@[@"A", @"B", @"C"]];
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
