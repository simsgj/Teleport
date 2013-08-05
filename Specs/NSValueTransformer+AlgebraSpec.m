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
        NSValueTransformer *transformer1 = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"%@_", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(0, value.length-1)];
        }];
        
        NSValueTransformer *transformer2 = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSString* value) {
            return  [NSString stringWithFormat:@"_%@", value];
        } reverseBlock:^id(NSString *value) {
            return [value substringWithRange:NSMakeRange(1, value.length-1)];
        }];

        
        NSValueTransformer *chain = [NSValueTransformer chainValueTansformers:@[transformer1, transformer2]];
        
        NSString *a = @"A";
        NSString *c = @"_A_";
        
        [[[chain transformedValue:a] should] equal:c];
        [[[chain reverseTransformedValue:c] should] equal:a];

        
    });
});

SPEC_END
