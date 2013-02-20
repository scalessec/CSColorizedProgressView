/***************************************************************************

CSColorizedProgressView.h
CSColorizedProgressView
Version 1.0

Copyright (c) 2013 Charles Scalesse.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"), 
to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

***************************************************************************/


#import <UIKit/UIKit.h>

typedef enum {
    CSColorizedProgressViewDirectionBottomToTop,
    CSColorizedProgressViewDirectionTopToBottom,
    CSColorizedProgressViewDirectionLeftToRight,
    CSColorizedProgressViewDirectionRightToLeft
} CSColorizedProgressViewDirection;

typedef void (^CSColorizedCompletionBlock)(CGFloat);

@interface CSColorizedProgressView : UIView

// The full-color image
@property (nonatomic, retain) UIImage *image;

// From 0.0 to 1.0
@property (nonatomic, assign) CGFloat progress;

// Default is bottom to top
@property (nonatomic, assign) CSColorizedProgressViewDirection direction;

// The duration of the progress bar animation, in seconds, to go from 0% to 100% uninterrupted.
// The update animation speed is based on this value. Default is 1 second.
@property (nonatomic, assign) CGFloat totalAnimationDuration;

// When animating, there is a delay between when the target progress is set and
// when the actual progress catches up. This block will be invoked when the progress bar
// has completed animating. It returns the current progress.
@property (nonatomic, copy) CSColorizedCompletionBlock completionBlock;

// Initialize with an image and set the bounds to the image's size
- (id)initWithImage:(UIImage *)image;

// Set the progress with an animation
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

// Cancels a running animation
- (void)stopAnimation;

// Adjusts the frame to fit the image
- (void)sizeToFit;

@end
