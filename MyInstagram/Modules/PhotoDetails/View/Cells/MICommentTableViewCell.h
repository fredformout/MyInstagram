//
//  MICommentTableViewCell.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIInstagramComment.h"

@interface MICommentTableViewCell : UITableViewCell

- (void)configureWithComment:(MIInstagramComment *)comment;

@end
