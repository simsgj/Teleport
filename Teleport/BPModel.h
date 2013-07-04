//
//  BPModel.h
//  Teleport
//
//  Created by Luca on 6/25/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPModel : NSObject <NSCoding>

+(id)modelFromDictionary:(NSDictionary*)dictionary;

-(id)initWithDictionary:(NSDictionary*)dictionary;
-(NSDictionary*)dictionary;

-(NSDictionary*) serializer;
-(NSDictionary*) transformers;

@end
