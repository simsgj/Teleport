//
//  NSValueTransformer+UIImage.m
//  Teleport
//
//  Created by Luca on 04/12/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformer+UIImage.h"
#import "Teleport.h"
@implementation NSValueTransformer (UIImage)
+(NSValueTransformer *)imageToBase64StringTansformer
{
    return [NSValueTransformer chainValueTansformers:@[[NSValueTransformerWithBlock reversibleTransformerWithBlock:^id(UIImage *value) {
        
        NSParameterAssert([value isKindOfClass:[UIImage class]]);
        
        return UIImagePNGRepresentation(value);

    } reverseBlock:^id(NSData *value) {

        NSParameterAssert([value isKindOfClass:[NSData class]]);

        return [UIImage imageWithData:value];
    }], [NSValueTransformer dataToBase64StringTansformer]]];
}
@end
