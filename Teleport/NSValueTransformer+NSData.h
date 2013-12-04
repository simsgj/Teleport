//
//  NSValueTransformer+NSData.h
//  Teleport
//
//  Created by Luca on 04/12/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (NSData)
+(NSValueTransformer *)dataToBase64StringTansformer;

@end
