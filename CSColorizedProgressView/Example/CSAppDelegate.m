//
//  CSAppDelegate.m
//  CSColorizedProgressView
//
//  Created by Charles Scalesse on 2/7/13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "CSAppDelegate.h"
#import "CSViewController.h"

@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.viewController = [[[CSViewController alloc] init] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)dealloc {
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
