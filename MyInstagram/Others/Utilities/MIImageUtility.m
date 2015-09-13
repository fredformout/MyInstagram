//
//  CImageTools.m
//  arm
//
//  Created by fredformout on 17.01.13.
//  Copyright (c) 2013 Flexis. All rights reserved.
//

#import "MIImageUtility.h"
#import "UIImage+ImageEffects.h"

static CGFloat kIpadWidth = 1024.0;
static CGFloat kIpadHeight = 768.0;
static CGFloat kPadding = 50.0;

@implementation MIImageUtility

+ (CGSize)sizeOfImageConstraintsToSize:(CGSize)size
                                 image:(UIImage *)image
                               padding:(BOOL)padding
{
    CGSize resultSize;
    CGFloat constraintWidth;
    CGFloat constraintHeight;
    
    if (padding == YES)
    {
        constraintWidth = size.width - 2 * kPadding;
        constraintHeight = size.height - 2 * kPadding;
    }
    else
    {
        constraintWidth = size.width;
        constraintHeight = size.height;
    }
    
    if (image.size.width <= constraintWidth
        && image.size.height <= constraintHeight)
    {
        resultSize = image.size;
    }
    else if (image.size.width <= constraintWidth
             && image.size.height > constraintHeight)
    {
        CGFloat koef = image.size.height / constraintHeight;
        resultSize = CGSizeMake(image.size.width / koef, constraintHeight);
    }
    else if (image.size.width > constraintWidth
             && image.size.height <= constraintHeight)
    {
        CGFloat koef = image.size.width / constraintWidth;
        resultSize = CGSizeMake(constraintWidth, image.size.height / koef);
    }
    else if (image.size.width > constraintWidth
             && image.size.height > constraintHeight)
    {
        CGFloat widthDiff = image.size.width - constraintWidth;
        CGFloat heightDiff = image.size.height - constraintHeight;
        
        if (widthDiff >= heightDiff)
        {
            CGFloat koef = image.size.width / constraintWidth;
            resultSize = CGSizeMake(constraintWidth, image.size.height / koef);
        }
        else
        {
            CGFloat koef = image.size.height / constraintHeight;
            resultSize = CGSizeMake(image.size.width / koef, constraintHeight);
        }
    }
    
    return resultSize;
}

+ (CGSize)sizeOfImageConstraintsToFullScreen:(UIImage *)image
{
    return [self sizeOfImageConstraintsToSize:CGSizeMake(kIpadWidth, kIpadHeight)
                                        image:image
                                      padding:YES];
}

+ (UIImage *)imageFromBundleByFilename:(NSString *)filename
{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
    NSString *fullPath = [bundlePath stringByAppendingPathComponent:filename];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

+ (UIImage *)imageFromDocumentsByFilename:(NSString *)filename
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentDirectory, filename];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

+ (UIImage *)resizeImageWithImage:(UIImage *)image
                             size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)roundImageWithImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(image.size);

    CGRect imageBounds = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);

    [[UIBezierPath bezierPathWithRoundedRect:imageBounds
                                cornerRadius:imageBounds.size.width / 2.0] addClip];

    [image drawInRect:imageBounds];
    
    UIImage *returnValue = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return returnValue;
}

+ (void)saveImage:(UIImage *)image
         filename:(NSString *)filename
{
    NSArray *components = [filename componentsSeparatedByString:@"."];
    NSData *data = nil;
    
    if ([[components lastObject] isEqualToString:@"png"])
    {
        data = UIImagePNGRepresentation(image);
    }
    else
    {
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:filename];
    
    [data writeToFile:filePath
           atomically:NO];
}

+ (UIImage *)renderSnapshot:(UIView *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(snapshot.bounds.size, NO, 0);
    
    [snapshot drawViewHierarchyInRect:snapshot.bounds
                   afterScreenUpdates:YES];
    UIImage *returnValue = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return returnValue;
}

+ (UIImage *)renderSnapshot:(UIView *)view
                   withSize:(CGSize)renderSize
{
    CGRect originalFrame = view.frame;
    CGRect renderFrame = CGRectMake(view.frame.origin.x, view.frame.origin.y, renderSize.width, renderSize.height);
    
    view.frame = renderFrame;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage *returnValue = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    view.frame = originalFrame;
    
    return returnValue;
}

+ (UIImage *)blurryImageFromView:(UIView *)view
                            blur:(CGFloat)blur
{
    UIImage *viewImage = [self renderSnapshot:view];

    return [viewImage applyBlurWithRadius:blur
                                tintColor:[UIColor colorWithWhite:0.0
                                                            alpha:0.5]
                    saturationDeltaFactor:1.8f
                                maskImage:nil];
}

+ (UIImage *)blurryScreenshotFromView:(UIView *)view
{
    return [self blurryImageFromView:view
                                blur:5.0f];
}

@end
