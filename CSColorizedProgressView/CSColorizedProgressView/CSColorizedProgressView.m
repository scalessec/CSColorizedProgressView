//
//  CSColorizedProgressView.m
//  CSColorizedProgressView
//
//  Created by Charles Scalesse on 2/7/13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "CSColorizedProgressView.h"

@interface CSColorizedProgressView ()

@property (nonatomic, retain) UIImageView *startImageView;
@property (nonatomic, retain) UIImageView *endImageView;
@property (nonatomic, retain) UIView *clippingView;
@property (nonatomic, retain) NSTimer *progressTimer;

- (void)setup;
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

#pragma mark - Events

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        [_image release];
        _image = [image retain];
    }
    
    _startImageView.image = [self grayscaleImageForImage:_image];
    _endImageView.image = _image;
    
    [self setNeedsLayout];
}

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    _progress = progress;
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)setDirection:(CSColorizedProgressViewDirection)direction {
    _direction = direction;
    [self setNeedsLayout];
}

- (void)sizeToFit {
    if (_image == nil) return;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _image.size.width, _image.size.height);
}

- (void)layoutSubviews {
    _startImageView.frame = _endImageView.frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    _clippingView.frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height / 2);
}

#pragma mark - Grayscale

- (UIImage *)grayscaleImageForImage:(UIImage *)image {
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGColorSpaceRef grayscaleColorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, grayscaleColorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, imageRect, image.CGImage);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *grayscaleImage = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(grayscaleColorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    return grayscaleImage;
}

@end
