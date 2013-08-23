//
//  NSValueTransformer+Collections.h
//  Teleport
//
//  Created by Luca on 23/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (Collections)

+(NSValueTransformer*)mutableArrayToArrayValueTansformer;
+(NSValueTransformer*)mutableSetToArrayValueTansformer;
+(NSValueTransformer*)setToArrayValueTansformer;

@end
