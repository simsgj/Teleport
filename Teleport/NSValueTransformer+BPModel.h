//
//  NSValueTransformer+BPModel.h
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (BPModel)

+(NSValueTransformer*)arrayValueTansformer:(NSValueTransformer*)itemTransformer;
+(NSValueTransformer*)enumValueTansformer:(NSDictionary*)dictionary;
+(NSValueTransformer*)modelValueTansformer:(Class)model;
+(NSValueTransformer*)modelsValueTansformer:(Class)model;

@end
