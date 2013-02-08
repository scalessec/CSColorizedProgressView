//
//  CSViewController.m
//  CSColorizedProgressView
//
//  Created by Charles Scalesse on 2/7/13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "CSViewController.h"
#import "CSColorizedProgressView.h"

@interface CSViewController ()

@end

@implementation CSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CSColorizedProgressView *colorizedProgressView = [[[CSColorizedProgressView alloc] initWithImage:[UIImage imageNamed:@"paris.png"]] autorelease];
    [self.view addSubview:colorizedProgressView];
}

@end
