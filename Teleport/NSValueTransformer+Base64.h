//
//  NSValueTransformer+Base64.h
//  Sneak Peek
//
//  Created by Luca on 6/26/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (Base64)
+(NSValueTransformer*)stringToBase64ValueTansformer;
+(NSValueTransformer*)dataToBase64ValueTansformer;

@end
