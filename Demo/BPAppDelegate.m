//
//  BPAppDelegate.m
//  Teleport
//
//  Created by Luca on 6/26/13.
//  Copyright (c) 2013 BendingSpoons. All rights reserved.
//

#import "BPAppDelegate.h"

@implementation BPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
