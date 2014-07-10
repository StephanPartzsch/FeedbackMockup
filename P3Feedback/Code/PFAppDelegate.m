//
//  PFAppDelegate.m
//  P3Feedback
//
//  Created by Stephan Partzsch on 09.07.14.
//  Copyright (c) 2014 P3. All rights reserved.
//

#import "PFAppDelegate.h"
#import "JSObjectionInjector.h"
#import "JSObjection.h"

@implementation PFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	JSObjectionInjector *injector = [JSObjection createInjector];
	[JSObjection setDefaultInjector:injector];

    return YES;
}

@end
