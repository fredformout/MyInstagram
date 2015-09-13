//
//  MIBorderedView.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface MIBorderedView : UIView

@property (nonatomic, assign) IBInspectable CGFloat leftWidth;
@property (nonatomic, assign) IBInspectable CGFloat topWidth;
@property (nonatomic, assign) IBInspectable CGFloat rightWidth;
@property (nonatomic, assign) IBInspectable CGFloat bottomWidth;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable BOOL borderScaling;

@end