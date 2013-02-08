//
//  CSColorizedProgressView.m
//  CSColorizedProgressView
//
//  Created by Charles Scalesse on 2/7/13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "CSColorizedProgressView.h"

static const CGFloat CSAnimationInterval = 0.01;

@interface CSColorizedProgressView ()

@property (nonatomic, assign) CGFloat targetProgress;
@property (nonatomic, assign) NSUInteger currentStep;
@property (nonatomic, assign) NSUInteger requiredSteps;
@property (nonatomic, retain) UIImageView *startImageView;
@property (nonatomic, retain) UIImageView *endImageView;
@property (nonatomic, retain) UIView *clippingView;
@property (nonatomic, retain) NSTimer *progressTimer;

- (void)setup;
- (void)updateProgress;
- (UIImage *)grayscaleImageForImage:(UIImage *)image;

@end

@implementation CSColorizedProgressView

#pragma mark - Factories & Dealloc

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    if (self) {
        [self setup];
        self.image = image;
    }
    return self;
}

- (void)dealloc {
    self.image = nil;
    self.startImageView = nil;
    self.endImageView = nil;
    self.clippingView = nil;
    [super dealloc];
}

- (void)setup {
    _progress = 0.0;
    _targetProgress = 0.0;
    
    _currentStep = 0;
    _requiredSteps = 0;
    
    _totalAnimationDuration = 1.0;
    
    _direction = CSColorizedProgressViewDirectionBottomToTop;
    
    self.startImageView = [[[UIImageView alloc] init] autorelease];
    self.endImageView = [[[UIImageView alloc] init] autorelease];
    self.clippingView = [[[UIView alloc] init] autorelease];
    
    _startImageView.backgroundColor = [UIColor clearColor];
    _endImageView.backgroundColor = [UIColor clearColor];
    _clippingView.backgroundColor = [UIColor clearColor];
    
    _clippingView.clipsToBounds = YES;
    
    [self addSubview:_endImageView];
    [self addSubview:_clippingView];
    [_clippingView addSubview:_startImageView];
}

#pragma mark - Progress & Layout

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    CGFloat validatedProgress = MAX(0.0, MIN(progress, 1.0));
    
    if (animated && _totalAnimationDuration > CSAnimationInterval) {
        _targetProgress = validatedProgress;
        CGFloat varianceFactor = fabsf(_targetProgress - _progress);
        CGFloat animationDuration = varianceFactor * _totalAnimationDuration;
        _currentStep = 0;
        _requiredSteps = (animationDuration / CSAnimationInterval);
        self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:CSAnimationInterval target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    } else {
        _progress = validatedProgress;
        [self setNeedsLayout];
    }
}

- (void)setProgressTimer:(NSTimer *)progressTimer {
    if (_progressTimer != progressTimer) {
        [_progressTimer invalidate];
        [_progressTimer release];
        _progressTimer = [progressTimer retain];
    }
}

- (void)updateProgress {
    if (_currentStep == _requiredSteps) {
        self.progress = _targetProgress;
        self.progressTimer = nil;
        if (_completionBlock != nil) {
            _completionBlock(_progress);
        }
    } else {
        self.progress = _progress + (CSAnimationInterval * (1 / _totalAnimationDuration));
        _currentStep++;
    }
}

- (void)setDirection:(CSColorizedProgressViewDirection)direction {
    _direction = direction;
    [self setNeedsLayout];
}

- (void)sizeToFit {
    if (_image == nil) return;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _image.size.width, _image.size.height);
}

- (void)layoutSubviews {
    _startImageView.frame = _endImageView.frame = _clippingView.frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);

    CGFloat remainingProgress = 1.0 - _progress;
    
    switch (_direction) {
        case CSColorizedProgressViewDirectionBottomToTop: {
            CGFloat newHeight = _image.size.height * remainingProgress;
            _clippingView.frame = CGRectMake(0.0, 0.0, _image.size.width, newHeight);
            break;
        }
        case CSColorizedProgressViewDirectionTopToBottom: {
            CGFloat newHeight = _image.size.height * _progress;
            _startImageView.frame = CGRectMake(0.0, -newHeight, _startImageView.frame.size.width, _startImageView.frame.size.height);
            _clippingView.frame = CGRectMake(0.0, 0.0 + newHeight, _image.size.width, _image.size.height - newHeight);
            break;
        }
        case CSColorizedProgressViewDirectionLeftToRight: {
            CGFloat newWidth = _image.size.width * _progress;
            _startImageView.frame = CGRectMake(-newWidth, 0.0, _startImageView.frame.size.width, _startImageView.frame.size.height);
            _clippingView.frame = CGRectMake(0.0 + newWidth, 0.0, _image.size.width - newWidth, _image.size.height );
            break;
        }
        case CSColorizedProgressViewDirectionRightToLeft: {
            CGFloat newWidth = _image.size.width * remainingProgress;
            _clippingView.frame = CGRectMake(0.0, 0.0, newWidth, _image.size.height);
            break;
        }
    }
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        [_image release];
        _image = [image retain];
    }
    
    _startImageView.image = [self grayscaleImageForImage:_image];
    _endImageView.image = _image;
    
    [self setNeedsLayout];
}

- (void)setTotalAnimationDuration:(CGFloat)totalAnimationDuration {
    _totalAnimationDuration = MAX(0.0, totalAnimationDuration);
}

- (void)stopAnimation {
    self.progressTimer = nil;
}

#pragma mark - Grayscale

- (UIImage *)grayscaleImageForImage:(UIImage *)image {
    // Adapted from this thread: http://stackoverflow.com/questions/1298867/convert-image-to-grayscale
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width * image.scale, image.size.height * image.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef
                                                 scale:image.scale
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}

@end
