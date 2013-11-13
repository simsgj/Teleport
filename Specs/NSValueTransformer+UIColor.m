//
//  NSValueTransformer+BPModelSpec.m
//  Teleport
//
//  Created by Luca on 6/26/13.
//  Copyright 2013 BendingSpoons. All rights reserved.
//

#import "Kiwi.h"
#import "NSValueTransformer+UIColor.h"
#import "BPModel.h"

@implementation UIColor (isEqualToColor)

- (BOOL)isEqualToColor:(UIColor *)otherColor {
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            return [UIColor colorWithCGColor:CGColorCreate(colorSpaceRGB, components)];
        } else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(self);
    otherColor = convertColorToRGBSpace(otherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isEqual:otherColor];

}

@end


SPEC_BEGIN(NSValueTransformer_UIColorSpec)

describe(@"NSValueTransformer+UIColor", ^{
   
    it(@"should allow to transform UIColor", ^{
        UIColor *color1 = [UIColor redColor];
        UIColor *color2 = [UIColor colorWithRed:.3 green:.99 blue:.31 alpha:0.7];
        UIColor *color3 = [UIColor colorWithWhite:1 alpha:0];


        NSValueTransformer *transformer = [NSValueTransformer colorToStringValueTansformer];
        NSString *string1 = [transformer transformedValue:color1];
        NSString *string2 = [transformer transformedValue:color2];
        NSString *string3 = [transformer transformedValue:color3];
        
        UIColor *color1a = [transformer reverseTransformedValue:string1];
        UIColor *color2a = [transformer reverseTransformedValue:string2];
        UIColor *color3a = [transformer reverseTransformedValue:string3];
        
        
        [[theValue([color1 isEqualToColor:color1a]) should] beTrue];
        [[theValue([color2 isEqualToColor:color2a]) should] beTrue];
        [[theValue([color3 isEqualToColor:color3a]) should] beTrue];
        
        NSLog(@"");
    });
});

SPEC_END
