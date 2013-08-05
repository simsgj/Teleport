//
//  NSValueTransformer+NSString.h
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (NSString)
+(NSValueTransformer*)stringToNumberValueTansformer:(NSNumberFormatterStyle)formatterStyle;
@end
