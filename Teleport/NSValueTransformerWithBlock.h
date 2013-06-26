//
//  NSValueTransformerWithBlock.h
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^NSValueTransformerBlock)(id value);

@interface NSValueTransformerWithBlock : NSValueTransformer

+ (instancetype)transformerWithBlock:(NSValueTransformerBlock)forwardBlock;
+ (instancetype)reversibleTransformerWithBlock:(NSValueTransformerBlock)forwardBlock reverseBlock:(NSValueTransformerBlock)reverseBlock;

@end
