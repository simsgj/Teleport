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

});

SPEC_END
