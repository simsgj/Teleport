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
+(id)modelsFromArray:(NSArray*)array;

-(id)initWithDictionary:(NSDictionary*)dictionary;
-(void)updateWithDictionary:(NSDictionary*)dictionary;

-(NSDictionary*)dictionary;

-(NSDictionary*) serializer;
-(NSDictionary *)deserializer;
-(NSDictionary*) transformers;

-(void)beforSerialize:(NSDictionary*)dictionary;
-(void)afterSerialize:(NSDictionary*)dictionary;
-(void)beforDeserialize:(NSDictionary*)dictionary;
-(void)afterDeserialize:(NSDictionary*)dictionary;

@end
