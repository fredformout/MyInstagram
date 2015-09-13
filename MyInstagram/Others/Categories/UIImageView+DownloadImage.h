//
//  UIImageView+DownloadImage.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DownloadImage)

@property (nonatomic, copy) NSURL *imageURL;

- (void)loadImageFromURL:(NSURL*)url
              cachingKey:(NSString*)key;

@end
