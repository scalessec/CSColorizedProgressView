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

typedef void (^CSColorizedCompletionBlock)();

@interface CSColorizedProgressView : UIView

- (id)initWithImage:(UIImage *)image;

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) CSColorizedProgressViewDirection direction; // default is down to up

// when animating progress, there is a delay between when the progress is set and
// when the actual animation catches up. This block will fire when the progress bar
// has completed animating to 100%
@property (nonatomic, copy) CSColorizedCompletionBlock completionBlock;

// progress range is 0.0 to 1.0
- (void)setProgress:(CGFloat)progress;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

// adjusts the frame to fit the image
- (void)sizeToFit;

@end
