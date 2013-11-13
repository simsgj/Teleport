//
//  NSValueTransformer+UIColor.m
//  Teleport
//
//  Created by Luca on 13/11/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+UIColor.h"

@implementation NSValueTransformer (UIColor)

+(NSValueTransformer *)colorToStringValueTansformer
{
    
    return [NSValueTransformerWithBlock reversibleTransformerWithBlock:^ NSString* (UIColor *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[UIColor class]]);
        
        CGColorSpaceRef colorSpace = CGColorGetColorSpace(value.CGColor);
        CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpace);
        
        NSAssert(colorSpaceModel == kCGColorSpaceModelMonochrome || colorSpaceModel == kCGColorSpaceModelRGB, @"color space model not supported");

        const CGFloat *components = CGColorGetComponents(value.CGColor);
        
        if (colorSpaceModel == kCGColorSpaceModelMonochrome)
            return [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[0], components[0], components[1]];
        else
            return [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];

        
        
    } reverseBlock:^UIColor* (NSString *value) {
        NSParameterAssert(value);
        NSParameterAssert([value isKindOfClass:[NSString class]]);
        
        NSArray *components = [value componentsSeparatedByString:@","];
        CGFloat r = [[components objectAtIndex:0] floatValue];
        CGFloat g = [[components objectAtIndex:1] floatValue];
        CGFloat b = [[components objectAtIndex:2] floatValue];
        CGFloat a = [[components objectAtIndex:3] floatValue];
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
        
    }];
}

@end
