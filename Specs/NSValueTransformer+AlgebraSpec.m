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
    
    it(@"should allow to transform each element (Array)", ^{
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];
        
        NSValueTransformer *arrayTransformer = [NSValueTransformer eachValueTansformer:prefixTransformer];
        
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
    
    it(@"should allow to transform each element (Dictionary)", ^{
        
        NSValueTransformer *prefixTransformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];
        
        NSValueTransformer *eachTransformer = [NSValueTransformer eachValueTansformer:prefixTransformer];
        
        NSDictionary *values = @{@1 : @"A", @2: @"B", @3 : @"C"};
        NSDictionary *expectedTransformedValue = @{@1 : @"_A", @2: @"_B", @3 : @"_C"};
        
        id transformedValue = [eachTransformer transformedValue:values];
        id reverseTransformedValue  = [eachTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        [[reverseTransformedValue should] equal:values];
        
        [[transformedValue should] beKindOfClass:[NSDictionary class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableDictionary class]];
        [[reverseTransformedValue should] beKindOfClass:[NSDictionary class]];
        [[reverseTransformedValue shouldNot] beKindOfClass:[NSMutableDictionary class]];
        
        transformedValue = [eachTransformer transformedValue:[values mutableCopy]];
        reverseTransformedValue  = [eachTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] beKindOfClass:[NSDictionary class]];
        [[transformedValue should] beKindOfClass:[NSMutableDictionary class]];
        [[reverseTransformedValue should] beKindOfClass:[NSDictionary class]];
        [[reverseTransformedValue should] beKindOfClass:[NSMutableDictionary class]];
        
        
    });

});

SPEC_END
