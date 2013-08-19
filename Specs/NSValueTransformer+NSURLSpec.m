//
//  NSValueTransformer+BPModelSpec.m
//  Teleport
//
//  Created by Luca on 6/26/13.
//  Copyright 2013 BendingSpoons. All rights reserved.
//

#import "Kiwi.h"
#import "NSValueTransformer+NSURLSpec.m"
#import "NSValueTransformer+NSURL.h"


SPEC_BEGIN(NSValueTransformer_NSURLSpec)

describe(@"NSValueTransformer+BPModel", ^{
    
    it(@"should allow to transform NSURL", ^{
        NSString *string = @"https://doma.in/path/page?query=true";
        NSURL *URL = [NSURL URLWithString:string];
        
        NSValueTransformer *transformer = [NSValueTransformer URLToStringValueTansformer];
        [[[transformer transformedValue:URL] should] equal:string];
        [[[transformer reverseTransformedValue:string] should] equal:URL];

        
    });
    

    
});

SPEC_END
