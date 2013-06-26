//
//  NSValueTransformer+BPModelSpec.m
//  Teleport
//
//  Created by Luca on 6/26/13.
//  Copyright 2013 BendingSpoons. All rights reserved.
//

#import "Kiwi.h"
#import "NSValueTransformer+BPModel.h"
#import "BPModel.h"

typedef NS_ENUM(NSUInteger, MyEnum) {
    MyEnumValue1,
    MyEnumValue2
};

@interface BPMyModel2 : BPModel
@property (nonatomic) BOOL boolean;
@property (nonatomic) NSNumber *number;
@end

@implementation BPMyModel2
-(NSDictionary *)serializer
{
    return @{
             @"boolean" : @"_boolean",
             @"number" : @"_number"
             };
}
@end

SPEC_BEGIN(NSValueTransformer_BPModelSpec)

describe(@"NSValueTransformer+BPModel", ^{
   
    it(@"should allow to transform enum", ^{
        NSValueTransformer *transformer = [NSValueTransformer enumValueTansformer:@{@(MyEnumValue1): @"1", @(MyEnumValue2) : @"2"}];
        [[[transformer transformedValue:@(MyEnumValue1)] should] equal:@"1"];
        [[[transformer transformedValue:@(MyEnumValue2)] should] equal:@"2"];
        [[[transformer reverseTransformedValue:@"1"] should] equal:@(MyEnumValue1)];
        [[[transformer reverseTransformedValue:@"2"] should] equal:@(MyEnumValue2)];
    });
    
    it(@"should allow to transform models", ^{
        BPMyModel2 *model = [BPMyModel2 modelFromDictionary:@{@"_number" : @3, @"_boolean": @(YES)}];
        NSValueTransformer *transformer = [NSValueTransformer modelValueTansformer:[BPMyModel2 class]];
        [[[transformer transformedValue:model][@"_boolean"] should] equal:@YES];
        [[[transformer transformedValue:model][@"_number"] should] equal:@3];
    });
    
});

SPEC_END
