//
//  UIImageView+DownloadImage.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "UIImageView+DownloadImage.h"
#import <objc/runtime.h>
#import "FTWCache.h"

static char kUrlKey;

@implementation UIImageView (DownloadImage)

@dynamic imageURL;

- (void)loadImageFromURL:(NSURL *)url
              cachingKey:(NSString *)key
{
    self.imageURL = url;
    
    NSData *data = [FTWCache objectForKey:key];
    
    if (!data)
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(queue, ^
        {
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *imageFromData = [UIImage imageWithData:data];
            
            [FTWCache setObject:UIImageJPEGRepresentation(imageFromData, 0.0)
                         forKey:key];
            
            UIImage *imageToSet = imageFromData;
            
            if (imageToSet)
            {
                if ([self.imageURL.absoluteString isEqualToString:url.absoluteString])
                {
                    dispatch_async(dispatch_get_main_queue(), ^
                    {
                        self.image = imageFromData;
                    });
                }
            }
        });
    }
    else
    {
        self.image = [UIImage imageWithData:data];
    }
}

- (void)setImageURL:(NSURL *)newImageURL
{
    objc_setAssociatedObject(self, &kUrlKey, newImageURL, OBJC_ASSOCIATION_COPY);
}

- (NSURL*)imageURL
{
    return objc_getAssociatedObject(self, &kUrlKey);
}

@end
