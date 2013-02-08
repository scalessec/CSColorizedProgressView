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
- (IBAction)handleDirectionTapped:(UIButton *)directionButton;

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
}

#pragma mark - Events

- (IBAction)handleAnimateTapped {
    [self handleResetTapped];
    [_colorizedProgressView setProgress:1.0 animated:YES];
}

- (IBAction)handleResetTapped {
    [_colorizedProgressView stopAnimation];
    _colorizedProgressView.progress = 0.0;
}

- (IBAction)handleDirectionTapped:(UIButton *)directionButton {
    switch (directionButton.tag) {
        case 0: _colorizedProgressView.direction = CSColorizedProgressViewDirectionBottomToTop; break;
        case 1: _colorizedProgressView.direction = CSColorizedProgressViewDirectionTopToBottom; break;
        case 2: _colorizedProgressView.direction = CSColorizedProgressViewDirectionLeftToRight; break;
        case 3: _colorizedProgressView.direction = CSColorizedProgressViewDirectionRightToLeft; break;
    }
}

@end
