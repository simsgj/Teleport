//
//  NSValueTransformerWithBlock.m
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "NSValueTransformerWithBlock.h"

@interface NSValueTransformerWithBlock ()
@property (nonatomic, copy) NSValueTransformerBlock forwardBlock;
@property (nonatomic, copy) NSValueTransformerBlock reverseBlock;
@end

@interface NSReversibleValueTransformerWithBlock : NSValueTransformerWithBlock
@end

@implementation NSValueTransformerWithBlock


+ (instancetype)transformerWithBlock:(NSValueTransformerBlock)forwardBlock
{
    NSParameterAssert(forwardBlock);
    return [[NSValueTransformerWithBlock alloc] initWithForwardBlock:forwardBlock reverseBlock:NULL];
}

+ (instancetype)reversibleTransformerWithBlock:(NSValueTransformerBlock)forwardBlock reverseBlock:(NSValueTransformerBlock)reverseBlock
{
    NSParameterAssert(forwardBlock);
    NSParameterAssert(reverseBlock);
    return [[NSReversibleValueTransformerWithBlock alloc] initWithForwardBlock:forwardBlock reverseBlock:reverseBlock];
}


- (id)initWithForwardBlock:(NSValueTransformerBlock)forwardBlock reverseBlock:(NSValueTransformerBlock)reverseBlock
{
    self = [super init];
    if (self) {
        self.forwardBlock = forwardBlock;
        self.reverseBlock = reverseBlock;
    }
    return self;
}

+ (BOOL)allowsReverseTransformation {
	return NO;
}

+ (Class)transformedValueClass {
	return [NSObject class];
}

- (id)transformedValue:(id)value {
	return self.forwardBlock(value);
}

@end

@implementation NSReversibleValueTransformerWithBlock

+ (BOOL)allowsReverseTransformation {
	return YES;
}

- (id)reverseTransformedValue:(id)value {
	return self.reverseBlock(value);
}

@end
