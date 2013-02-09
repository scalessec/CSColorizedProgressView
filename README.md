CSColorizedProgressView
=============
*Version 1.0*

`CSColorizedProgressView` is a progress view that transitions a grayscale image to a full color image. It looks like this:
![CSColorizedProgressView Screenshots](http://i.imgur.com/eca5SM7.png)

Basic Usage
---------
    UIImage *image = [UIImage imageNamed:@"paris.png"]; // full-color image
    CSColorizedProgressView *colorizedProgressView = [[[CSColorizedProgressView alloc] initWithImage:image] autorelease];
    [self.view addSubview:colorizedProgressView];
    
    [colorizedProgressView setProgress:0.75 animated:YES];

`CSColorizedProgressView` also supports a completion block for animations. This is especially useful for when the progress reaches 1.0, but your application UI shouldn't respond until the progress meter visually reaches completion.

    colorizedProgressView.completionBlock = ^(CGFloat completedProgress) {
        if (completedProgress == 1.0) {
            NSLog(@"Progress completed!");
        }
    };

Setup Instructions
------------------
1. Add `CSColorizedProgressView.h` & `CSColorizedProgressView.m` to your project.
2. If you're using ARC, you'll need to add the `-fno-objc-arc` compiler flag to `CSColorizedProgressView.m`.


MIT License
-----------
    Copyright (c) 2013 Charles Scalesse.

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.