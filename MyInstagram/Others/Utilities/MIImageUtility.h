//
//  CImageTools.h
//  arm
//
//  Created by fredformout on 17.01.13.
//  Copyright (c) 2013 Flexis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIImageUtility : NSObject

+ (CGSize)sizeOfImageConstraintsToSize:(CGSize)size
                                 image:(UIImage *)image
                               padding:(BOOL)padding;
+ (CGSize)sizeOfImageConstraintsToFullScreen:(UIImage *)image;
+ (UIImage *)imageFromBundleByFilename:(NSString *)filename;
+ (UIImage *)imageFromDocumentsByFilename:(NSString *)filename;
+ (UIImage *)resizeImageWithImage:(UIImage *)image
                             size:(CGSize)size;
+ (UIImage *)roundImageWithImage:(UIImage *)image;
+ (void)saveImage:(UIImage *)image
         filename:(NSString *)filename;

+ (UIImage *)renderSnapshot:(UIView *)snapshot;
+ (UIImage *)renderSnapshot:(UIView *)view
                   withSize:(CGSize)renderSize;

+ (UIImage *)blurryImageFromView:(UIView *)view
                            blur:(CGFloat)blur;

+ (UIImage *)blurryScreenshotFromView:(UIView *)view;

@end
