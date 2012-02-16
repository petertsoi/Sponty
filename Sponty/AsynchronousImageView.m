//
//  AsynchronousImageView.m
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "AsynchronousImageView.h"

@interface AsynchronousImageView ()
- (UIImage *)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize;
@end

@implementation AsynchronousImageView

@synthesize isLoaded;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        isLoaded = NO;
    }
    return self;
}

- (void) layoutSubviews {
    if (!self.image) {
        [self setBackgroundColor:[UIColor blackColor]];
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [spinner setCenter:self.center];
        
        UIView * test = [[UIView alloc] init];
        [test setFrame:CGRectMake(0, 0, spinner.frame.size.width, spinner.frame.size.height)];
        [test setBackgroundColor:[UIColor blackColor]];
        [spinner startAnimating];
        [self addSubview:spinner];
    }
}

- (void)loadImageFromURLString:(NSString *)theUrlString{
    [self.image release],
    self.image = nil; 
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:theUrlString]
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:30.0];                          
    
    connection = [[NSURLConnection alloc]
                  initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData {    
    if (data == nil)
        data = [[NSMutableData alloc] initWithCapacity:2048];                 
    
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection{
    isLoaded = YES;
    UIImage * download =  [self p_imageByScalingImage:[UIImage imageWithData:data] toSize:self.frame.size];

    self.image = download;
    [spinner stopAnimating];
    [data release];
    data = nil; 
    [connection release];
    connection = nil;
}

#pragma mark - Private
- (UIImage *)p_imageByScalingImage:(UIImage *)image toSize:(CGSize)targetSize{
    UIImage* sourceImage = image; 
    CGFloat targetWidth;
    CGFloat targetHeight;
    if (IS_RETINA){
        targetWidth = targetSize.width * 2;
        targetHeight = targetSize.height * 2;
    } else {
        targetWidth = targetSize.width;
        targetHeight = targetSize.height;
    }
    CGImageRef imageRef = [sourceImage CGImage];
    if (YES) { // CROP STUFF
        float targetAspect = targetSize.width / targetSize.height;
        float currentAspect = image.size.width / targetSize.height;
        CGRect cropRect;
        if (currentAspect > targetAspect) { // currently too tall
            cropRect = CGRectMake(0.0,  (image.size.height - (image.size.width / targetAspect))/2, image.size.width, image.size.width / targetAspect);
        } else {
            cropRect = CGRectMake((image.size.width - (targetAspect * image.size.height)/2), 0.0, image.size.height * targetAspect, image.size.height);
        }
        imageRef = CGImageCreateWithImageInRect(imageRef, cropRect);
    }
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);

    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBitsPerComponent(imageRef) * image.size.width, colorSpaceInfo, bitmapInfo);
        
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBitsPerComponent(imageRef) * image.size.width, colorSpaceInfo, bitmapInfo);
        
    }       
    
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }

    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRelease(imageRef);

    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

- (void) dealloc {
    [spinner release];
    [super dealloc];
}

@end
