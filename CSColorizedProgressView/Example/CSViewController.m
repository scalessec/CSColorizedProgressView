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

- (IBAction)handleAnimateTapped;
- (IBAction)handleResetTapped;

@end

@implementation CSViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colorizedProgressView.image = [UIImage imageNamed:@"paris.png"];
    _colorizedProgressView.completionBlock = ^(CGFloat completedProgress) {
        if (completedProgress == 1.0) {
            NSLog(@"Progress completed!");
        }
    };
    [self.view addSubview:_colorizedProgressView];
}

#pragma mark - Events

- (IBAction)handleAnimateTapped {
    [_colorizedProgressView setProgress:1.0 animated:YES];
}

- (IBAction)handleResetTapped {
    [_colorizedProgressView stopAnimation];
    _colorizedProgressView.progress = 0.0;
}

@end
