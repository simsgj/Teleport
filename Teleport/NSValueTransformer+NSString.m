//
//  NSValueTransformer+NSString.m
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+NSString.h"
#import "Teleport.h"

@implementation NSValueTransformer (NSString)

+(NSValueTransformer*)stringToNumberValueTansformer:(NSNumberFormatterStyle)formatterStyle
{
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(id value) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:formatterStyle];
        return  [formatter numberFromString:value];
    } reverseBlock:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
}

@end
