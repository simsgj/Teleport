//
//  NSValueTransformerWithBlock.m
//  Teleport
//
//  Created by Luca on 6/26/13.
//  Copyright 2013 BendingSpoons. All rights reserved.
//

#import "Kiwi.h"
#import "NSValueTransformerWithBlock.h"

SPEC_BEGIN(NSValueTransformerWithBlockSpec)

describe(@"NSValueTransformerWithBlock", ^{
   
    it(@"reversibleTransformerWithBlock should transform back and forward", ^{
        
        NSValueTransformer *tansformer = [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(NSNumber *number) {
            return @([number integerValue] +10);
        } reverseBlock:^id(NSNumber *number) {
            return @([number integerValue] -10);
        }];
        
        [[[tansformer transformedValue:@3] should] equal:@13];
        [[[tansformer reverseTransformedValue:@13] should] equal:@3];
        
        [[theValue([[tansformer class] allowsReverseTransformation]) should] beTrue];

    });
    
    it(@"transformerWithBlock should transform", ^{
        
        NSValueTransformer *tansformer = [NSValueTransformerWithBlock transformerWithBlock:^id(NSNumber *value) {
            return [NSString stringWithFormat:@"%d", [value integerValue]];
        }];
        
        [[[tansformer transformedValue:@3] should] equal:@"3"];
        
        [[theBlock(^{
            [tansformer reverseTransformedValue:@"3"];
        }) should] raise];

        [[theValue([[tansformer class] allowsReverseTransformation]) should] beFalse];
        
    });
    
});

SPEC_END
