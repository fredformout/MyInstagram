//
//  MIWithAddCommentPanelViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIWithAddCommentPanelViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *addCommentPanelView;
@property (nonatomic, weak) IBOutlet UITextField *commentTextField;
@property (nonatomic, weak) IBOutlet UIButton *sendCommentButton;

- (void)sendCommentWithText:(NSString *)text;

@end
