//
//  NSValueTransformer+AlgebraSpec.m
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "Kiwi.h"
#import "Teleport.h"

@interface BPMyModel3 : BPModel
@property (nonatomic) BOOL boolean;
@property (nonatomic) NSNumber *number;
@end

@implementation BPMyModel3
-(NSDictionary *)serializer
{
    return @{
             @"boolean" : @"_boolean",
             @"number" : @"_number"
             };
}
@end


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
    
    it(@"should allow to transform collection (Dictionary)", ^{
        

        
        NSValueTransformer *eachValueTransformer = [NSValueTransformer eachValueTansformer:[NSValueTransformer modelValueTansformer:[BPMyModel3 class]]];
        
        NSValueTransformer *dictionaryTransformer =  [NSValueTransformer chainValueTansformers:@[[NSValueTransformer dictionaryToArrayValueTansformerWithIndex:@"number"], eachValueTransformer]];
        
        BPMyModel3 *model1 = [BPMyModel3 modelFromDictionary:@{@"_number" : @1, @"_boolean": @(NO)}];
        BPMyModel3 *model2 = [BPMyModel3 modelFromDictionary:@{@"_number" : @2, @"_boolean": @(YES)}];
        
        NSDictionary *values = @{@1 : model1, @2 : model2};
        NSArray *expectedTransformedValue = @[model1.dictionary, model2.dictionary];
        
        NSArray *transformedValue = [dictionaryTransformer transformedValue:values];
        NSDictionary* reverseTransformedValue  = [dictionaryTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        [[reverseTransformedValue should] haveCountOf:2];
        
        [[[reverseTransformedValue[@1] number] should] equal:@1];
        [[[reverseTransformedValue[@2] number] should] equal:@2];
        [[theValue([reverseTransformedValue[@1] boolean]) should] equal:@NO];
        [[theValue([reverseTransformedValue[@2] boolean]) should] equal:@YES];
        
        [[transformedValue should] beKindOfClass:[NSArray class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableArray class]];
        [[reverseTransformedValue shouldNot] beKindOfClass:[NSMutableDictionary class]];
        [[reverseTransformedValue should] beKindOfClass:[NSDictionary class]];

    });
    
    
    it(@"should allow to transform collection (Dictionary - mutable)", ^{
        
        NSValueTransformer *eachValueTransformer = [NSValueTransformer eachValueTansformer:[NSValueTransformer modelValueTansformer:[BPMyModel3 class]]];
        
        NSValueTransformer *dictionaryTransformer =  [NSValueTransformer chainValueTansformers:@[[NSValueTransformer mutableDictionaryToArrayValueTansformerWithIndex:@"number"], eachValueTransformer]];
        
        BPMyModel3 *model1 = [BPMyModel3 modelFromDictionary:@{@"_number" : @1, @"_boolean": @(NO)}];
        BPMyModel3 *model2 = [BPMyModel3 modelFromDictionary:@{@"_number" : @2, @"_boolean": @(YES)}];
        
        NSMutableDictionary *values = [@{@1 : model1, @2 : model2} mutableCopy];
        NSArray *expectedTransformedValue = @[model1.dictionary, model2.dictionary];
        
        NSArray *transformedValue = [dictionaryTransformer transformedValue:values];
        NSDictionary* reverseTransformedValue  = [dictionaryTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        
        [[transformedValue should] beKindOfClass:[NSArray class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableArray class]];
        [[reverseTransformedValue should] beKindOfClass:[NSMutableDictionary class]];
        [[reverseTransformedValue should] beKindOfClass:[NSDictionary class]];
        
    });
    
    it(@"should allow to transform collection (mutabledictionary to dictionary)", ^{
        
        NSValueTransformer *eachValueTransformer = [NSValueTransformer eachValueTansformer:[NSValueTransformer modelValueTansformer:[BPMyModel3 class]]];
        
        NSValueTransformer *dictionaryTransformer =  [NSValueTransformer chainValueTansformers:@[eachValueTransformer, [NSValueTransformer mutableDictionaryToDictionaryValueTansformer]]];
        
        BPMyModel3 *model1 = [BPMyModel3 modelFromDictionary:@{@"_number" : @1, @"_boolean": @(NO)}];
        BPMyModel3 *model2 = [BPMyModel3 modelFromDictionary:@{@"_number" : @2, @"_boolean": @(YES)}];
        
        NSMutableDictionary *values = [@{@1 : model1, @2 : model2} mutableCopy];
        NSDictionary *expectedTransformedValue = @{@1 : model1.dictionary, @2 : model2.dictionary};
        
        id transformedValue = [dictionaryTransformer transformedValue:values];
        id reverseTransformedValue  = [dictionaryTransformer reverseTransformedValue:transformedValue];
        
        [[transformedValue should] equal:expectedTransformedValue];
        
        [[transformedValue should] beKindOfClass:[NSDictionary class]];
        [[transformedValue shouldNot] beKindOfClass:[NSMutableDictionary class]];
        [[reverseTransformedValue should] beKindOfClass:[NSMutableDictionary class]];
        
    });
    
    


});

SPEC_END
