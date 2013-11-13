//
//  NSValueTransformer+Algebra.h
//  Teleport
//
//  Created by Luca on 05/08/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (Algebra)
+(NSValueTransformer*)eachValueTansformer:(NSValueTransformer*)itemTransformer;
+(NSValueTransformer*)chainValueTansformers:(NSArray*)transformers;

@end
