//
//  CSColorizedProgressView.h
//  CSColorizedProgressView
//
//  Created by Charles Scalesse on 2/7/13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CSColorizedProgressViewDirectionDownToUp,
    CSColorizedProgressViewDirectionUpToDown,
    CSColorizedProgressViewDirectionLeftToRight,
    CSColorizedProgressViewDirectionRightToLeft
} CSColorizedProgressViewDirection;

typedef void (^CSColorizedCompletionBlock)(CGFloat);

@interface CSColorizedProgressView : UIView

- (id)initWithImage:(UIImage *)image;

// The full-color image
@property (strong, nonatomic) UIImage *image;

// From 0.0 to 1.0
@property (assign, nonatomic) CGFloat progress;

// Default is down to up
@property (assign, nonatomic) CSColorizedProgressViewDirection direction;

// The length of the progress bar animation, in seconds, to go 0% to 100% uninterrupted.
// The update animation speed is based on this value. Default is 1 second.
@property (assign, nonatomic) CGFloat totalAnimationDuration;

// When animating, there is a delay between when the target progress is set and
// when the actual progress catches up. This block will be invoked when the progress bar
// has completed animating. It returns the current progress.
@property (nonatomic, copy) CSColorizedCompletionBlock completionBlock;

// Set the progress with an animation
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

// Cancels a running animation
- (void)stopAnimation;

// Adjusts the frame to fit the image
- (void)sizeToFit;

@end
