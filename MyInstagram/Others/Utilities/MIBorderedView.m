//
//  MIBorderedView.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBorderedView.h"

@implementation MIBorderedView

- (UIColor *)borderColor
{
    if (_borderColor == nil)
    {
        _borderColor = [UIColor clearColor];
    }
    
    return _borderColor;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.cornerRadius;

    CGFloat scale = 1.0f;
    
    if (self.borderScaling)
    {
        scale = [[UIScreen mainScreen] scale];
    }

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, rect.size.height - (self.bottomWidth / scale), rect.size.width, (self.bottomWidth / scale));
    bottomBorder.backgroundColor = self.borderColor.CGColor;
    [self.layer addSublayer:bottomBorder];

    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, rect.size.width, (self.topWidth / scale));
    topBorder.backgroundColor = self.borderColor.CGColor;
    [self.layer addSublayer:topBorder];

    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, (self.leftWidth / scale), rect.size.height);
    leftBorder.backgroundColor = self.borderColor.CGColor;
    [self.layer addSublayer:leftBorder];

    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(rect.size.width-(self.rightWidth / scale), 0.0f, (self.rightWidth / scale), rect.size.height);
    rightBorder.backgroundColor = self.borderColor.CGColor;
    [self.layer addSublayer:rightBorder];
}

@end